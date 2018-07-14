//
//  PriceDetailedVC.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDetailedVC.h"
#import "PriceDetailedSubVC.h"
#import "IndexView.h"
#import "BaseTypeView.h"
#import "WSLineChartView.h"

#import "CurrencySelectVC.h"

@interface PriceDetailedVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate,BaseTypeViewDelegate>

@property(nonatomic,strong)IndexView *indexView;
@property (nonatomic, strong)WSLineChartView *lineChartView;
@property (nonatomic, strong) NSArray *turnovers;
@property (nonatomic, strong) NSArray *Yturnovers;

@property(nonatomic,strong)BaseTypeView *baseTypeView;

@property (nonatomic,strong) NSMutableArray *flagArray;
@end

@implementation PriceDetailedVC
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tabBar.frame = CGRectMake(0, CGRectGetMaxY(self.baseTypeView.frame), CGRectGetWidth(self.view.frame), 30);
    _pagerController.view.frame = CGRectMake(0, CGRectGetMaxY(_tabBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- CGRectGetMaxY(_tabBar.frame));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self initNavtionBar];
    
    [self creatPriceView];
    [self creatChartView];
    [self creatBaseTypeView];

    [self addTabPageBar];
    [self addPagerController];
    
    self.flagArray = [NSMutableArray arrayWithObjects:@"介绍",@"资金净流入",@"换手率",@"持币地址变化率",@"社区活跃度",@"市场表现", nil];
    [self reloadData];
    
    // Do any additional setup after loading the view.
}

-(void)initNavtionBar{
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"行情详情";
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    
    UIButton *finish = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [finish setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:finish];
    
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)finishClick{
    CurrencySelectVC *vc=[CurrencySelectVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)creatPriceView{
    IndexView *indexView =[[IndexView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 60)];
    self.indexView = indexView;
    indexView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:indexView];
    
}
-(void)creatChartView{

    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++) {
        
        [xArray addObject:[NSString stringWithFormat:@"%.1f",3+0.1*i]];
        [yArray addObject:[NSString stringWithFormat:@"%.2lf",20.0+arc4random_uniform(10)]];
        
    }
    
    WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indexView.frame), UIScreenW, 180) xTitleArray:xArray yValueArray:yArray yMax:30 yMin:20];
    self.lineChartView = wsLine;
    [self.view addSubview:wsLine];
    
}

-(void)creatBaseTypeView{
    BaseTypeView *baseTypeView =[[BaseTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineChartView.frame)+10, UIScreenW, 35)];
    self.baseTypeView = baseTypeView;
    baseTypeView.delegate = self;
    [self.view addSubview:baseTypeView];
}

- (void)addTabPageBar {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    tabBar.layout.progressWidth = 80;
    tabBar.layout.progressHeight = 2;
    tabBar.layout.progressColor = [UIColor colorWithHex:@"#1161a0"];
    tabBar.layout.normalTextColor = [UIColor colorWithHex:@"#848484"];
    tabBar.layout.selectedTextColor = [UIColor colorWithHex:@"#0e5f9f"];
    tabBar.layout.cellSpacing = 0;
    tabBar.layout.cellEdging = 0;
    tabBar.layout.cellWidth = SCREEN_WIDTH/2;
    tabBar.layout.normalTextFont = AdaptedFontSize(24);
    tabBar.layout.selectedTextFont = AdaptedFontSize(24);
    tabBar.dataSource = self;
    tabBar.delegate = self;
    [tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.view addSubview:tabBar];
    _tabBar = tabBar;

}
- (void)addPagerController {
    TYPagerController *pagerController = [[TYPagerController alloc]init];
    pagerController.layout.prefetchItemCount = 1;
    //pagerController.layout.autoMemoryCache = NO;
    // 只有当scroll滚动动画停止时才加载pagerview，用于优化滚动时性能

    pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
    pagerController.dataSource = self;
    pagerController.delegate = self;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
}

#pragma mark - TYTabPagerBarDataSource
- (NSInteger)numberOfItemsInPagerTabBar {
    return self.flagArray.count;
}
- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = self.flagArray[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate
- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    return SCREEN_WIDTH/3;
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    _currentIndex = index;
    [_pagerController scrollToControllerAtIndex:index animate:YES];
}


#pragma mark - TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController {
    return self.flagArray.count;
}
- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    PriceDetailedSubVC *vc = [[PriceDetailedSubVC alloc]init];
    [vc loadMainTableData:self.flagArray[index] isPull:NO];
    return vc;
}

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    _currentIndex = toIndex;
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)reloadData {
    _tabBar.layout.cellWidth = SCREEN_WIDTH/4;
    [_tabBar reloadData];
    [_pagerController reloadData];
}

#pragma mark BaseTypeViewDelegate
-(void)gmdOpFenXiClick{
    self.flagArray = [NSMutableArray arrayWithObjects:@"介绍",@"资金净流入",@"换手率",@"持币地址变化率",@"社区活跃度",@"市场表现", nil];
    [self reloadData];
}
-(void)gmdOpYuCeClick{
    self.flagArray = [NSMutableArray arrayWithObjects:@"短期预测",@"长期预测", nil];
    [self reloadData];
}
-(void)gmdOpYuJingClick{
    self.flagArray = [NSMutableArray arrayWithObjects:@"币地址检测",@"交易量预警",@"换手量预警", nil];
    [self reloadData];
    
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
