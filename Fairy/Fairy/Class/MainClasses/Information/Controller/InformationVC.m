//
//  InformationVC.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "InformationVC.h"
#import "InformationSubVC.h"

@interface InformationVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>

@property (nonatomic,strong) NSMutableArray *flagArray;

@end

@implementation InformationVC
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _tabBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44);
    _pagerController.view.frame = CGRectMake(0, CGRectGetMaxY(_tabBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- CGRectGetMaxY(_tabBar.frame)-LL_StatusBarHeight);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initNavtionBar];
    
    [self addTabPageBar];
    [self addPagerController];
    [self reloadData];
    // Do any additional setup after loading the view.
}
-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"资讯";
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
}

- (void)addTabPageBar {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.backgroundColor = [UIColor grayColor];
    tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    tabBar.layout.progressWidth = 50;
    tabBar.layout.progressHeight = 2;
    tabBar.layout.progressColor = [UIColor colorWithHex:@"#0080d9"];
    tabBar.layout.normalTextColor = [UIColor blackColor];
    tabBar.layout.selectedTextColor = [UIColor blueColor];
    tabBar.layout.cellSpacing = 0;
    tabBar.layout.cellEdging = 0;
    tabBar.layout.cellWidth = SCREEN_WIDTH/2;
    tabBar.layout.normalTextFont = [UIFont boldSystemFontOfSize:13];
    tabBar.layout.selectedTextFont = [UIFont boldSystemFontOfSize:14];
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
    return SCREEN_WIDTH/self.flagArray.count;
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
    InformationSubVC *vc = [[InformationSubVC alloc]init];
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
    _tabBar.layout.cellWidth = SCREEN_WIDTH/5;
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
        _flagArray = [NSMutableArray arrayWithObjects:@"最新",@"币聊",@"微博",@"其他", nil];
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
