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

#import "WSLineChartView.h"



@interface PriceDetailedVC ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate,CompareCellDelegate>

@property (nonatomic, strong) FSBaseTableView *tableView;
@property (nonatomic, strong) FSBottomTableViewCell *contentCell;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic,strong)NSMutableArray *flagArray;

@property (nonatomic,strong)NSMutableArray* firstDataArr;
@property (nonatomic,strong)NSMutableArray*secondDataArr;


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
    UIView *viewTitle = [[UIView alloc] init];
    viewTitle.frame = CGRectMake(0, 0, 150, 36);

    UILabel *fromLab =[[ UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 18)];
    fromLab.font = AdaptedFontSize(30);
    fromLab.textColor = [UIColor whiteColor];
    fromLab.textAlignment = NSTextAlignmentCenter;
    fromLab.text = self.priceModel.platformCnName;
    [viewTitle addSubview:fromLab];
    
    UILabel *nameLab =[[ UILabel alloc]initWithFrame:CGRectMake(0, 18, 150, 18)];
    nameLab.font = AdaptedFontSize(30);
    nameLab.textColor = [UIColor whiteColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.text = [NSString stringWithFormat:@"%@/%@",self.priceModel.fsym,self.priceModel.tsyms];
    [viewTitle addSubview:nameLab];
    self.navigationItem.titleView =viewTitle;

    
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 128;
        }
        else if (indexPath.row == 2){
            return 60;
        }
        else{
            if (self.secondDataArr.count>0) {
                return 195*2;
            }
            return 195;
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
            vc.title = self.flagArray[i];
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
    }else if (indexPath.row == 2){
        CompareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompareCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    else{
        WSLineChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSLineChartCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.firstDataArr = self.firstDataArr;
        cell.secondDataArr = self.secondDataArr;
        return cell;
    }
    
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
    TrendVC *vc=[TrendVC new];
    vc.priceModel = self.priceModel;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)cellPlatformClick{
    CurrencySelectVC *vc=[CurrencySelectVC new];
    vc.block = ^(NSString *content) {
        [self requestSelectData:content];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)requestData{

    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPair"] = self.priceModel.fsym;
    
    [NetworkManage Get:coinmarketcapHistory andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            self.firstDataArr = [NSMutableArray array];
            self.firstDataArr = obj[@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)requestSelectData:(NSString*)type{

    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPair"] = type;
    [NetworkManage Get:coinmarketcapHistory andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            self.secondDataArr = obj[@"data"];
            
            //指定刷新某行cell
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
