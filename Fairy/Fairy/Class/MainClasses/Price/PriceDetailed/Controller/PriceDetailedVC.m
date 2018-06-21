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

#import "CurrencySelectVC.h"

@interface PriceDetailedVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>

@property(nonatomic,strong)IndexView *indexView;
@property (nonatomic, strong)LineChartView *lineChartView;
@property (nonatomic, strong) NSArray *turnovers;
@property (nonatomic, strong) NSArray *Yturnovers;

@property(nonatomic,strong)BaseTypeView *baseTypeView;

@property (nonatomic,strong) NSMutableArray *flagArray;
@end

@implementation PriceDetailedVC
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tabBar.frame = CGRectMake(0, CGRectGetMaxY(self.baseTypeView.frame), CGRectGetWidth(self.view.frame), 36);
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

    LineChartView *lineChartView = [[LineChartView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indexView.frame), UIScreenW-6, 180)];
    [self.view addSubview:lineChartView];
    self.lineChartView = lineChartView;
    
    lineChartView.doubleTapToZoomEnabled = NO;//禁止双击缩放 有需要可以设置为YES
    lineChartView.gridBackgroundColor = [UIColor blueColor];//表框以及表内线条的颜色以及隐藏设置 根据自己需要调整
    lineChartView.borderColor = [UIColor grayColor];
    lineChartView.drawGridBackgroundEnabled = NO;
    lineChartView.drawBordersEnabled = NO;
    //    lineChartView.descriptionText = @"XXX";//该表格的描述名称
    //    lineChartView.descriptionTextColor = [UIColor whiteColor];//描述字体颜色
    
    lineChartView.legend.enabled = YES;//是否显示折线的名称以及对应颜色 多条折线时必须开启 否则无法分辨
    lineChartView.legend.textColor = [UIColor redColor];//折线名称字体颜色
    
    //设置动画时间
    [lineChartView animateWithXAxisDuration:1];
    
    //    设置纵轴坐标显示在左边而非右边
    self.lineChartView.leftAxis.enabled = NO;//不绘制左边轴
    
    ChartYAxis *rightAxis = self.lineChartView.rightAxis;//获取左边Y轴
    rightAxis.drawGridLinesEnabled = NO;//不绘制网格线
    rightAxis.labelTextColor = [UIColor blueColor];
    rightAxis.axisLineColor = [UIColor whiteColor];//Y轴颜色
    
    //设置横轴坐标显示在下方 默认显示是在顶部
    ChartXAxis *xAxis = lineChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelTextColor = [UIColor blueColor];
    xAxis.labelCount = 3;
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
    
    //用于存放多个折线数据的数组
    NSMutableArray *sets = [NSMutableArray array];
    
    //turnovers是用于存放模型的数组
    //模型数组 这里是使用的随机生成的模型数据
    self.turnovers = @[
                       @{
                           @"name" : @"10",
                           @"icon" : @"15"
                           },
                       @{
                           @"name" : @"20",
                           @"icon" : @"30"
                           },
                       @{
                           @"name" : @"30",
                           @"icon" : @"15"
                           },
                       @{
                           @"name" : @"40",
                           @"icon" : @"30"
                           },
                       @{
                           @"name" : @"50",
                           @"icon" : @"15"
                           }
                       ];
    self.turnovers = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",];
    self.Yturnovers = @[@"15",@"20",@"15",@"40",@"60",@"80",@"15",@"40",@"60",@"80",@"15",@"33",@"70",];
    
    //横轴数据
    NSMutableArray *xValues = [NSMutableArray array];
    for (int i = 0; i < self.turnovers.count; i ++) {
        
        //取出模型数据
        //        ChartsModel *model = self.turnovers[i];
        //        [xValues addObject:model.enterDate];
        NSDictionary *dict= self.turnovers[i];
        [xValues addObject:self.turnovers[i]];
    }
    
    //设置横轴数据给chartview
    self.lineChartView.xAxis.valueFormatter = [[ChartIndexAxisValueFormatter alloc] initWithValues:xValues];
    
    
    
    //纵轴数据
    NSMutableArray *yValues1 = [NSMutableArray array];
    for (int i = 0; i < self.Yturnovers.count; i ++) {
        
        //        ChartsModel *model = self.turnovers[i];
        //        NSDictionary *dict= self.Yturnovers[i];
        double y = [self.Yturnovers[i] doubleValue];
        ChartDataEntry *entry = [[ChartDataEntry alloc]initWithX:i y:y];
        [yValues1 addObject:entry];
        
        //        [yValues1 addObject:dict[@"icon"]];
    }
    
    
    //创建LineChartDataSet对象
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:yValues1 label:@"成交额"];
    
    set1.circleRadius = 1.0;
    set1.circleHoleRadius = 0.5;
    [set1 setColor:[UIColor redColor]];
    set1.fillColor = UIColor.blueColor;
    set1.fillAlpha = 1.f;
    set1.mode = LineChartModeCubicBezier;
    set1.drawValuesEnabled = NO;
    set1.fillAlpha = 1.f;
    set1.drawFilledEnabled =YES;
    //sets内存放所有折线的数据 多个折线创建多个LineChartDataSet对象即可
    [sets addObject:set1];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:sets];
    
    self.lineChartView.data = data;
    
    
    
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 10)];
    titleLab.text =@"数据来源于www.baidu.com";
    titleLab.textColor =[UIColor redColor];
    titleLab.font =[UIFont systemFontOfSize:14];
    [self.lineChartView addSubview:titleLab];
    
    
    UIButton *compareBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.lineChartView.frame.size.width-30, 0, 30, 20)];
    [compareBtn setTitle:@"对比" forState:UIControlStateNormal];
    [compareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    compareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.lineChartView addSubview:compareBtn];

}

-(void)creatBaseTypeView{
    BaseTypeView *baseTypeView =[[BaseTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineChartView.frame), UIScreenW, 35)];
    self.baseTypeView = baseTypeView;
    baseTypeView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:baseTypeView];
}

- (void)addTabPageBar {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.backgroundColor =[UIColor whiteColor];
    tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    tabBar.layout.progressWidth = 80;
    tabBar.layout.progressHeight = 2;
    tabBar.layout.progressColor = [UIColor blueColor];
    tabBar.layout.normalTextColor = [UIColor blackColor];
    tabBar.layout.selectedTextColor = [UIColor blueColor];
    tabBar.layout.cellSpacing = 0;
    tabBar.layout.cellEdging = 0;
    tabBar.layout.cellWidth = SCREEN_WIDTH/2;
    tabBar.layout.normalTextFont = [UIFont boldSystemFontOfSize:15];
    tabBar.layout.selectedTextFont = [UIFont boldSystemFontOfSize:16];
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
    _tabBar.layout.cellWidth = SCREEN_WIDTH/3;
    [_tabBar reloadData];
    [_pagerController reloadData];
}

- (NSMutableArray *)flagArray
{
    if (_flagArray == nil) {
        _flagArray = [NSMutableArray arrayWithObjects:@"币地址检测",@"交易量预警",@"换手量预警",@"分析",@"币地址检测",@"交易量预警",@"换手量预警",@"分析", nil];
    }
    return _flagArray;
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
