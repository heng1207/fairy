//
//  PriceDetailedVC.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceDetailedVC.h"
#import "FSScrollContentView.h"//三方头文件
#import "FSBaseTableView.h"
#import "FSBottomTableViewCell.h"

#import "PriceDetailedSubVC.h"
#import "CurrencySelectVC.h"
#import "TrendVC.h"
#import "PriceDetailedCell.h"
#import "CompareCell.h"
#import "WSLineChartCell.h"
#import "MoneyTypeMonthCell.h"


@interface PriceDetailedVC ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate,CompareCellDelegate,MoneyTypeMonthCellDelegate>

@property (nonatomic, strong) FSBaseTableView *tableView;
@property (nonatomic, strong) FSBottomTableViewCell *contentCell;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic,strong)NSMutableArray *flagArray;

@property (nonatomic,strong)NSMutableArray* firstDataArr;
@property (nonatomic,strong)NSMutableArray*secondDataArr;
@property (nonatomic,strong)NSString *indexName;


@end

@implementation PriceDetailedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initNavtionBar];
    self.canScroll = YES;
    [self.view addSubview:self.tableView];

    [self requestData];
    
    // Do any additional setup after loading the view.
}

-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    ItemLab.text = [NSString stringWithFormat:@"%@/%@",self.priceModel.fsym,self.priceModel.tsyms];
    ItemLab.textAlignment = NSTextAlignmentCenter;
    [kUserDefaults setValue:self.priceModel.fsym forKey:KchoseCoin];

    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    
    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 50, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBack"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    [personalCenter setTitle:@"返回" forState:UIControlStateNormal];
    personalCenter.titleLabel.font = AdaptedFontSize(30);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    
//    UIButton *search = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
//    [search setImage:[UIImage imageNamed:@"searchLogo"] forState:UIControlStateNormal];
//    [search addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:search];
    
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchClick{

}

#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    
    if (self.secondDataArr.count>0) {
        return 6;
    }
    else{
        return 4;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 128;
        }
        else if (indexPath.row == 1){
            return 65;
        }
        else if (indexPath.row == 2){
            return 130;
        }
        else if (indexPath.row == 5){
            if (self.secondDataArr.count>0) {
                return 60;
            }
            else{
                return 0;
            }
        }
        else if (indexPath.row == 3){
            if (self.secondDataArr.count>0) {
                return 65;
            }
            else{
                return 60;
            }
        }
        else if (indexPath.row == 4){
            if (self.secondDataArr.count>0) {
                return 130;
            }
            else{
                return 0;
            }
        }
   
        
    }
    return CGRectGetHeight(self.view.bounds);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        _contentCell = [tableView dequeueReusableCellWithIdentifier:@"tabCell"];
        _contentCell.backgroundColor = [UIColor whiteColor];
        if (!_contentCell) {
            _contentCell = [[FSBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tabCell"];
        }
        
        NSMutableArray *contentVCs = [NSMutableArray array];
        for (NSInteger i =0; i<self.flagArray.count; i++) {
            PriceDetailedSubVC*vc = [[PriceDetailedSubVC alloc]init];
//            vc.title = self.flagArray[i];
            vc.coin = self.priceModel.fsym;
            [vc loadMainTableData:self.flagArray[i] Index:i PriceModel:nil];
          

            [contentVCs addObject:vc];
        }
        
        _contentCell.viewControllers = contentVCs;
        if (_contentCell.pageContentView) {
            [_contentCell.pageContentView removeFromSuperview];
            _contentCell.pageContentView = nil;
        }
        _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH ) childVCs:contentVCs parentVC:self delegate:self];
        _contentCell.pageContentView.backgroundColor = [UIColor whiteColor];
        [_contentCell.contentView addSubview:_contentCell.pageContentView];
        
        return _contentCell;
    }
    
    if (indexPath.row == 0) {
        PriceDetailedCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"PriceDetailedCell"  forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.priceModel;
        return cell;
    }
    else if (indexPath.row ==1){
        MoneyTypeMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyTypeMonthCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.titleLab.text= [NSString stringWithFormat:@"%@",self.priceModel.fsym];
        return cell;
    }
    else if (indexPath.row ==2){
        WSLineChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSLineChartCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row ==2) {
            cell.firstDataArr = self.firstDataArr;
        }
        else{
            cell.firstDataArr = self.secondDataArr;
        }
        
        return cell;
    }
    else if (indexPath.row == 3){
        if (self.secondDataArr.count>0) {
            MoneyTypeMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoneyTypeMonthCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            cell.titleLab.text= [NSString stringWithFormat:@"%@",self.indexName];
            return cell;
        }
        else{
            CompareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompareCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
    }
    else if (indexPath.row ==4){
        if (self.secondDataArr.count>0) {
            WSLineChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSLineChartCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.firstDataArr = self.secondDataArr;
            return cell;
        }

    }
    else if (indexPath.row == 5){
        if (self.secondDataArr.count>0) {
            CompareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompareCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }

    }
    
    return nil;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 26) titles:self.flagArray delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.titleFont = AdaptedFontSize(33);
    self.titleView.titleSelectFont = AdaptedFontSize(33);
    self.titleView.titleNormalColor = [UIColor colorWithHex:@"#000000"];
    self.titleView.titleSelectColor = [UIColor colorWithHex:@"#0e5f9f"];
    self.titleView.indicatorColor = [UIColor colorWithHex:@"#0e5f9f"];
    self.titleView.indicatorExtension = 10;
    return self.titleView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 26;
}

#pragma mark FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    _tableView.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    
    self.contentCell.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    _tableView.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}
- (FSBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[FSBaseTableView alloc]initWithFrame:CGRectMake(0, LL_StatusBarAndNavigationBarHeight, UIScreenW, UIScreenH-LL_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [_tableView registerClass:[WSLineChartCell class] forCellReuseIdentifier:@"WSLineChartCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PriceDetailedCell" bundle:nil] forCellReuseIdentifier:@"PriceDetailedCell"];
         [_tableView registerNib:[UINib nibWithNibName:@"CompareCell" bundle:nil] forCellReuseIdentifier:@"CompareCell"];
        [_tableView registerClass:[MoneyTypeMonthCell class] forCellReuseIdentifier:@"MoneyTypeMonthCell"];

        
        
    }
    return _tableView;
}
- (NSMutableArray *)flagArray
{
    if (_flagArray == nil) {
        _flagArray = [NSMutableArray arrayWithObjects:@"简介",@"数据",@"资金",@"进展",@"团队", nil];
    }
    return _flagArray;
}

#pragma mark CompareCellDelegate
-(void)cellTrendClick{
    CurrencySelectVC *vc=[CurrencySelectVC new];
    vc.block = ^(NSString *content) {
        self.indexName = content;
        [self requestSelectData:content];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)cellPlatformClick{
    TrendVC *vc=[TrendVC new];
    vc.priceModel = self.priceModel;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)requestData{

    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPair"] = self.priceModel.fsym;
    dict[@"moneyType"] = @"2";
    dict[@"month"] = @"3";
    
    [NetworkManage Get:coinmarketcapHistory andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            self.firstDataArr = [NSMutableArray array];
            self.firstDataArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)requestSelectData:(NSString*)type{

    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPair"] = type;
    dict[@"moneyType"] = @"2";
    dict[@"month"] = @"3";
    [NetworkManage Get:coinmarketcapHistory andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            self.secondDataArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
            [self.tableView reloadData];

        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark  MoneyTypeMonthCellDelegate
-(void)cellMoneyTypeMonthSelectMoneyType:(NSString *)moneyType Month:(NSString *)month Cell:(MoneyTypeMonthCell *)selectCell{
    
    NSIndexPath *index = [self.tableView indexPathForCell:selectCell];
    NSLog(@"%ld",(long)index.row);//上面1，下面3
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    if(index.row ==1) {
        dict[@"coinPair"] = self.priceModel.fsym;
    }
    else{
        dict[@"coinPair"] = self.indexName;
    }
    dict[@"moneyType"] = moneyType;
    dict[@"month"] = month;
    
    [NetworkManage Get:coinmarketcapHistory andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            if (index.row ==1) {
                self.firstDataArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }
            else{
                self.secondDataArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
                //指定刷新某行cell
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
}


-(void)dealloc{
    NSLog(@"%@",self);
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
