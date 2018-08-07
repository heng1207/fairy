//
//  PriceSubVC.m
//  Fairy
//
//  Created by  on 2018/8/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceSubVC.h"
#import "PriceCell.h"
#import "PriceDetailedVC.h"
#import "TrendVC.h"


@interface PriceSubVC ()<UITableViewDataSource, UITableViewDelegate,PriceCellDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *dataArrs;
@property (nonatomic, strong)PriceModel *selectModel;


@end

@implementation PriceSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.myTableView];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDatas)];
    [self.myTableView.mj_header beginRefreshing];
}

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-LL_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerNib:[UINib nibWithNibName:@"PriceCell" bundle:nil] forCellReuseIdentifier:@"PriceCell"];
        //        self.automaticallyAdjustsScrollViewInsets = YES;//解决tableview头部预留64像素的办法
    }
    return _myTableView;
}

#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark PriceCellDelegate
-(void)cellLongPress:(PriceCell *)priceCell{
    
    NSIndexPath *index=[self.myTableView indexPathForCell:priceCell];
    self.selectModel = self.dataArrs[index.row];
    
    if ([self.headType isEqualToString:@"自选"]) {
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
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPairID"] = self.selectModel.coinPairID;
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    dict[@"consumerID"] = userModel.consumerID;
    
    NSString *path =[NSString stringWithFormat:@"%@?token=%@",optionalDelete,userModel.token];
    __weak PriceSubVC *weakSelf = self;
    [NetworkManage Post:path andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        
        if ([obj[@"code"] integerValue] ==200 ) {
            
            [weakSelf.dataArrs removeObject:self.selectModel];
            [weakSelf.myTableView reloadData];

        }
        
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


-(void)loadDatas{
    
    if ([self.headType isEqualToString:@"自选"]) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        dict[@"consumerID"] = userModel.consumerID;
        
        NSString *path =[NSString stringWithFormat:@"%@?token=%@",optionalView,userModel.token];
        [NetworkManage Get:path andParams:dict success:^(id responseObject) {
            NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
            if ([obj[@"code"] integerValue] ==200 ) {
                self.dataArrs = [PriceModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [self.myTableView.mj_header endRefreshing];
                [self.myTableView reloadData];
            }
        } failure:^(NSError *error) {
            [self.myTableView.mj_header endRefreshing];
            NSLog(@"%@",error);
        }];
        
        
    }
    else{
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        dict[@"tradePlatformID"] = @"1";
        dict[@"coinPairType"] = self.headType;
        [NetworkManage Get:moneyClassContent andParams:dict success:^(id responseObject) {
            NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
            if ([obj[@"code"] integerValue] ==200 ) {
                // NSLog(@"%@",obj[@"data"]);
                self.dataArrs = [PriceModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [self.myTableView.mj_header endRefreshing];
                [self.myTableView reloadData];
            }
        } failure:^(NSError *error) {
            [self.myTableView.mj_header endRefreshing];
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
