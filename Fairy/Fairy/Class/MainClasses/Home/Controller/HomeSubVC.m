//
//  HomeSubVC.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "HomeSubVC.h"
#import "PriceCell.h"
#import "PriceModel.h"

@interface HomeSubVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) BOOL fingerIsTouch;

@property(nonatomic,strong)NSMutableArray *dataArrs;


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
    
    [self loadDatas];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"当前类型%@",self.headTypeID);
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
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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


-(void)loadDatas{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"tradePlatformID"] = @"1";
    dict[@"coinPairType"] = self.headTypeID;
    [NetworkManage Get:moneyClassContent andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
//            NSLog(@"%@",obj[@"data"]);
            self.dataArrs = [PriceModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
