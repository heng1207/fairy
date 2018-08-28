//
//  HomeSubVC.m
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "HomeSubVC.h"
#import "PriceCell.h"
#import "PriceModel.h"
#import "NewPriceDetailedVC.h"
#import "PriceDetailedVC.h"

#import "HomeVC.h"


@interface HomeSubVC ()<UITableViewDelegate,UITableViewDataSource,PriceCellDelegate>
@property (nonatomic, assign) BOOL fingerIsTouch;

@property(nonatomic,strong)NSMutableArray *dataArrs;
@property(nonatomic,strong)PriceModel *selectModel;


@end

@implementation HomeSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"PriceCell" bundle:nil] forCellReuseIdentifier:@"PriceCell"];
    [self.view addSubview:_tableView];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"当前类型%@",self.headTypeID);
    [self loadDatas];
}
#pragma mark Setter 刷新
- (void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;
}
#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArrs.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PriceCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"PriceCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.priceModel = self.dataArrs[indexPath.row];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    PriceDetailedVC *vc =[PriceDetailedVC new];
    vc.priceModel = self.dataArrs[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [[Tool getCurrentVC].navigationController pushViewController:vc animated:YES];
    
//    NewPriceDetailedVC *vc =[NewPriceDetailedVC new];
//    vc.priceModel = self.dataArrs[indexPath.row];
//    vc.hidesBottomBarWhenPushed = YES;
//    [[Tool getCurrentVC].navigationController pushViewController:vc animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark UIScrollView
//判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //接触屏幕
    self.fingerIsTouch = YES;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //离开屏幕
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (!self.vcCanScroll) {
//        scrollView.contentOffset = CGPointZero;
//    }
//    if (scrollView.contentOffset.y <= 0) {
//        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
//        //            return;
//        //        }
//        self.vcCanScroll = NO;
//        scrollView.contentOffset = CGPointZero;
////        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
//    }
//    self.tableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}

#pragma mark PriceCellDelegate
-(void)cellLongPress:(PriceCell *)priceCell{
    
    NSIndexPath *index=[self.tableView indexPathForCell:priceCell];
    self.selectModel = self.dataArrs[index.row];
    
    if ([self.headTypeID isEqualToString:@"自选"]) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定从自选删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag =1;
        [alert show];

    }else{
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定加入自选" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag =2;
        [alert show];
    }

    
}

#pragma mark UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //        NSLog(@"取消");
    }else{
        
        if (alertView.tag==1) {//删除自选
            [self deleteOptional];
        }
        else{//添加自选
            [self addOptional];
        }
        
    }
}

-(void)addOptional{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginStatus = [defaults objectForKey:@"loginStatus"];
    if ([loginStatus isEqualToString:@"未登录"]) {
        return;
    }
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPairID"] = self.selectModel.coinPairID;
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    dict[@"consumerID"] = userModel.consumerID;
//    dict[@"token"] = userModel.token;
    NSString *urlPath =[NSString stringWithFormat:@"%@?token=%@",optionalInsert,userModel.token];
    [NetworkManage Post:urlPath andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        
        
        int64_t delayInSeconds = 1.0;      // 延迟的时间
        /*
         *@parameter 1,时间参照，从此刻开始计时
         *@parameter 2,延时多久，此处为秒级，还有纳秒等。10ull * NSEC_PER_MSEC
         */
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // do something
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showSuccessWithStatus:obj[@"message"]];
            [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)deleteOptional{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginStatus = [defaults objectForKey:@"loginStatus"];
    if ([loginStatus isEqualToString:@"未登录"]) {
        return;
    }
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPairID"] = self.selectModel.coinPairID;
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    dict[@"consumerID"] = userModel.consumerID;
    
    NSString *path =[NSString stringWithFormat:@"%@?token=%@",optionalDelete,userModel.token];
    [NetworkManage Post:path andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        
        int64_t delayInSeconds = 1.0;      // 延迟的时间
        /*
         *@parameter 1,时间参照，从此刻开始计时
         *@parameter 2,延时多久，此处为秒级，还有纳秒等。10ull * NSEC_PER_MSEC
         */
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // do something
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showSuccessWithStatus:obj[@"message"]];
            [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
            
        });
        
        if ([obj[@"code"] integerValue] ==200 ) {
            
            [self.dataArrs removeObject:self.selectModel];
            [self.tableView reloadData];
        }

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)loadDatas{
    
    if ([self.headTypeID isEqualToString:@"自选"]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *loginStatus = [defaults objectForKey:@"loginStatus"];
        if ([loginStatus isEqualToString:@"未登录"]) {
            return;
        }
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        dict[@"consumerID"] = userModel.consumerID;
       
        NSString *path =[NSString stringWithFormat:@"%@?token=%@",optionalView,userModel.token];
        [NetworkManage Get:path andParams:dict success:^(id responseObject) {
            NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
            if ([obj[@"code"] integerValue] ==200 ) {
                self.dataArrs = [PriceModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [self.tableView reloadData];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
    }
    
    else{
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        dict[@"pageNo"] = @1;
        dict[@"pageSize"] = @10;
        if ([self.headTypeID isEqualToString:@"币值"]) {
            
        }
        else if ([self.headTypeID isEqualToString:@"Bitfinex"]){
            dict[@"tradePlatformID"] = @"1";
        }
        else if ([self.headTypeID isEqualToString:@"ZB"]){
            dict[@"tradePlatformID"] = @"4";
        }
        
        [NetworkManage Get:moneyClassContent andParams:dict success:^(id responseObject) {
            NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
            if ([obj[@"code"] integerValue] ==200 ) {
                self.dataArrs = [PriceModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [self.tableView reloadData];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
