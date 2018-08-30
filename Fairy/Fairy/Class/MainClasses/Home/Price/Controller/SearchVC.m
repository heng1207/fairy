//
//  SearchVC.m
//  Fairy
//
//  Created by 张恒 on 2018/8/30.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "SearchVC.h"
#import "NavView.h"
#import "PriceCell.h"
#import "PriceDetailedVC.h"

@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource,PriceCellDelegate,navViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArrs;

@end

@implementation SearchVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self creatSearchBar];
    
    // Do any additional setup after loading the view.
}

-(void)creatSearchBar{
    NavView *navView =[[NavView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, LL_StatusBarAndNavigationBarHeight)];
    navView.delegate = self;
    [self.view addSubview:navView];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[FSBaseTableView alloc]initWithFrame:CGRectMake(0, LL_StatusBarAndNavigationBarHeight, UIScreenW, UIScreenH-LL_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"PriceCell" bundle:nil] forCellReuseIdentifier:@"PriceCell"];
    }
    return _tableView;
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
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark NavViewDelegate
-(void)navViewSearch:(NSString *)searchStr{
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"pageNo"] = @"1";
    dict[@"pageSize"] = @"10";
    dict[@"fysm"] = searchStr;
    //http://47.254.69.147:8080/interface/coin_pair/list_data?pageNo=1&pageSize=10&fysm=b
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
-(void)navViewback{
    [self.navigationController popViewControllerAnimated:YES];
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
