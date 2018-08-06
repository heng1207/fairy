//
//  PriceSubVC.m
//  Fairy
//
//  Created by 张恒 on 2018/8/5.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceSubVC.h"
#import "PriceCell.h"
#import "PriceDetailedVC.h"
#import "TrendVC.h"


@interface PriceSubVC ()<UITableViewDataSource, UITableViewDelegate,PriceCellDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy)NSArray *dataArrs;


@end

@implementation PriceSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:self.myTableView];
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDatas)];
    [self.myTableView.mj_header beginRefreshing];
    
    
    // Do any additional setup after loading the view.
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
-(void)cellLongPress:(PriceCell*)priceCell{
    
}

-(void)loadDatas{
    
    if ([self.headType isEqualToString:@"自选"]) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        dict[@"consumerID"] = userModel.consumerID;
        
        NSString *path = [NSString stringWithFormat:@"%@/%@",optionalView,userModel.consumerID];
        [NetworkManage Get:path andParams:dict success:^(id responseObject) {
            NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
            if ([obj[@"code"] integerValue] ==200 ) {
                self.dataArrs = [PriceModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
                [self.myTableView.mj_header endRefreshing];
                [self.myTableView reloadData];
            }
        } failure:^(NSError *error) {
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
