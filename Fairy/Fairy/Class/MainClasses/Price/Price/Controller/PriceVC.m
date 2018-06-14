//
//  PriceVC.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceVC.h"
#import "PriceCell.h"
#import "PriceDetailedVC.h"
#import "CurrencySelectVC.h"
#import "TrendVC.h"


@interface PriceVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy)NSArray *dataArr;

@end

@implementation PriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initNavtionBar];
    [self.view addSubview:self.myTableView];

    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.myTableView.mj_header beginRefreshing];
    
    
    // Do any additional setup after loading the view.
}
-(void)initNavtionBar{
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"行情";
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
}


- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-LL_TabbarHeight-LL_StatusBarHeight) style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerNib:[UINib nibWithNibName:@"PriceCell" bundle:nil] forCellReuseIdentifier:@"PriceCell"];
//        self.automaticallyAdjustsScrollViewInsets = NO;//解决tableview头部预留64像素的办法
    }
    return _myTableView;
}

#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PriceCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"PriceCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    PriceDetailedVC *vc=[PriceDetailedVC new];
    
//    CurrencySelectVC *vc=[CurrencySelectVC new];
    TrendVC *vc=[TrendVC new];
    
    vc.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadNewData{
    [self.myTableView reloadData];
    [self.myTableView.mj_header endRefreshing];
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
