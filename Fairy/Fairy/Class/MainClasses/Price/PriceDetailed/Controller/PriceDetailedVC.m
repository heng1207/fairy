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

@interface PriceDetailedVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>

@property(nonatomic,strong)IndexView *indexView;
@property(nonatomic,strong)UIView *zheXianView;
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
    self.title = @"一台";
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self creatPriceView];
    [self creatZheXianView];
    [self creatBaseTypeView];

    [self addTabPageBar];
    [self addPagerController];


    [self reloadData];
    // Do any additional setup after loading the view.
}

-(void)creatPriceView{
    IndexView *indexView =[[IndexView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 60)];
    self.indexView = indexView;
    indexView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:indexView];
}
-(void)creatZheXianView{
    UIView *zheXianView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indexView.frame), UIScreenW, 180)];
    self.zheXianView = zheXianView;
    zheXianView.backgroundColor =[UIColor grayColor];
    [self.view addSubview:zheXianView];
}

-(void)creatBaseTypeView{
    BaseTypeView *baseTypeView =[[BaseTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.zheXianView.frame), UIScreenW, 35)];
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
    if (self.flagArray.count > 1) {
        _currentIndex = 1;
        [_pagerController scrollToControllerAtIndex:1 animate:NO];
    }
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
