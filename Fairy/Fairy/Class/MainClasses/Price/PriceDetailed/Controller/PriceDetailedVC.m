//
//  PriceDetailedVC.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceDetailedVC.h"
#import "PriceDetailedSubVC.h"
#import "IndexView.h"
#import "BaseTypeView.h"
#import "WSLineChartView.h"

#import "CurrencySelectVC.h"
#import "TrendVC.h"

@interface PriceDetailedVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate,BaseTypeViewDelegate,WSLineChartViewDelegate>

@property(nonatomic,strong)IndexView *indexView;
@property(nonatomic, strong)WSLineChartView *lineChartView;
@property(nonatomic,strong)BaseTypeView *baseTypeView;

@property(nonatomic,strong) NSArray *firstDataArr;
@property(nonatomic,strong) NSArray *secondDataArr;

@property(nonatomic,strong) NSMutableArray *flagArray;
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
  

//    [self creatBaseTypeView];
//    [self addTabPageBar];
//    [self addPagerController];

    
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

    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    
    UIButton *search = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [search setImage:[UIImage imageNamed:@"searchLogo"] forState:UIControlStateNormal];
    [search addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:search];
    
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchClick{

}


-(void)creatPriceView{
    IndexView *indexView =[[IndexView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 60)];
    self.indexView = indexView;
    [indexView setPriceModel:self.priceModel];
    indexView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:indexView];
    
}

-(void)creatBaseTypeView{
    BaseTypeView *baseTypeView =[[BaseTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineChartView.frame)+10, UIScreenW, 35)];
    self.baseTypeView = baseTypeView;
    baseTypeView.delegate = self;
    [self.view addSubview:baseTypeView];
}

- (void)addTabPageBar {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.backgroundColor = [UIColor colorWithHex:@"#e6e6e7"];
    tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    tabBar.layout.progressWidth = SCREEN_WIDTH/2;
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
    return SCREEN_WIDTH/2;
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
    [vc loadMainTableData:index isPull:NO];
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
    _tabBar.layout.cellWidth = SCREEN_WIDTH/2;
    [_tabBar reloadData];
    [_pagerController reloadData];
}

#pragma mark BaseTypeViewDelegate
-(void)gmdOpFenXiClick{
    [self fenXiData];
}

-(void)fenXiData{
    self.flagArray = [NSMutableArray arrayWithObjects:@"介绍",@"协整分析",@"币币比较",@"币变化对比",@"google关注与比价格关系",@"原油与币价格的关系",@"reddit关注度与币价格关系",@"汇率与币价格关系", nil];
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

#pragma mark WSLineChartViewDelegate
-(void)xAxisViewTapClick{
    TrendVC *vc=[TrendVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)xAxisViewCompareClick{
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
            self.firstDataArr = obj[@"data"];
            
            //获取显示区间最大值，最小值
            NSMutableArray *price = [NSMutableArray array];
            for (NSDictionary *item in obj[@"data"] ) {
                [price addObject: [NSNumber numberWithFloat:[item[@"closePrice"] floatValue]]];
            }
            CGFloat maxPrice = [[price valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minPrice = [[price valueForKeyPath:@"@min.floatValue"] floatValue];
            int maxSection = (maxPrice/10);
            int minSection = (minPrice/10);
            int maxPriceSection = maxSection*10+10;
            int minPriceSection = minSection*10;
//            NSLog(@"%f---%f",maxPrice,minPrice);
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *yArrays = [NSMutableArray array];
            NSMutableArray *yArray0 = [NSMutableArray array];
            [obj[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"historyDate"]];
                [yArray0 addObject:obj[@"closePrice"]];
            }];
            [yArrays addObject:yArray0];
            
            WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indexView.frame), UIScreenW, 180) xTitleArray:xArray yValueArray:yArrays yMax:maxPriceSection yMin:minPriceSection];
            self.lineChartView = wsLine;
            wsLine.delegate = self;
            [self.view addSubview:wsLine];
    
            [self creatBaseTypeView];
            [self addTabPageBar];
            [self addPagerController];
            
            [self fenXiData];
            [self reloadData];
            
            
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
            
            //获取显示区间最大值，最小值
            NSMutableArray *price = [NSMutableArray array];
            for (NSDictionary *item in obj[@"data"] ) {
                [price addObject: [NSNumber numberWithFloat:[item[@"closePrice"] floatValue]]];
            }
            for (NSDictionary *item in self.firstDataArr) {
                [price addObject: [NSNumber numberWithFloat:[item[@"closePrice"] floatValue]]];
            }
            CGFloat maxPrice = [[price valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minPrice = [[price valueForKeyPath:@"@min.floatValue"] floatValue];
            int maxSection = (maxPrice/10);
            int minSection = (minPrice/10);
            int maxPriceSection = maxSection*10+10;
            int minPriceSection = minSection*10;
            NSLog(@"%f---%f",maxPrice,minPrice);
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *yArrays = [NSMutableArray array];
            NSMutableArray *yArray0 = [NSMutableArray array];
            NSMutableArray *yArray1 = [NSMutableArray array];
            
            [self.firstDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"historyDate"]];
                [yArray0 addObject:obj[@"closePrice"]];
            }];
            
            [self.secondDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [xArray addObject:obj[@"historyDate"]];
                [yArray1 addObject:obj[@"closePrice"]];
            }];
            
            [yArrays addObject:yArray1];
            [yArrays addObject:yArray0];
            
            
            
       
            [self.lineChartView removeFromSuperview];
            self.lineChartView = nil;
            WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indexView.frame), UIScreenW, 180) xTitleArray:xArray yValueArray:yArrays yMax:maxPriceSection yMin:minPriceSection];
            self.lineChartView = wsLine;
            wsLine.delegate = self;
            [self.view addSubview:wsLine];
            
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
