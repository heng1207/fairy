//
//  HomeVC.m
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "HomeVC.h"
#import "FSScrollContentView.h"//三方头文件
#import "FSBaseTableView.h"
#import "FSBottomTableViewCell.h"
#import "HomeSubVC.h"
#import "IndexCell.h"
#import "GraphCell.h"
#import "SSSearchBar.h"
#import "NavView.h"


@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSBaseTableView *tableView;
@property (nonatomic, strong) FSBottomTableViewCell *contentCell;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic,strong) NSArray *globalIndexData;
@property (nonatomic,strong) NSArray* moneyClassData;
@property (nonatomic,strong) NSMutableDictionary *IndexTypeViewDic;

@end

@implementation HomeVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self loadNewData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(indexTypeClick:) name:@"indexTypeViewTypeSelect" object:nil];

    self.IndexTypeViewDic = [NSMutableDictionary dictionary];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatSearchBar];
    
    self.canScroll = YES;
    [self.view addSubview:self.tableView];
   
    [self loadNewData];
    
    // Do any additional setup after loading the view.
}

-(void)creatSearchBar{    
    NavView *navView =[[NavView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, LL_StatusBarAndNavigationBarHeight)];
    [self.view addSubview:navView];
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 142;
        }else{
            return 158;
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
    
        //            NSArray *titles = @[@"自选",@"基础链",@"社交通讯"];
        NSMutableArray *contentVCs = [NSMutableArray array];
        HomeSubVC*vc = [[HomeSubVC alloc]init];
        vc.title = @"自选";
        vc.headTypeID = @"自选";
        [contentVCs addObject:vc];
        for (NSInteger i =0; i<self.moneyClassData.count; i++) {
            HomeSubVC*vc = [[HomeSubVC alloc]init];
            NSDictionary *dict = self.moneyClassData[i];
            vc.title = dict[@"value"];
            vc.headTypeID = dict[@"code"];
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
        GraphCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GraphCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = self.IndexTypeViewDic;
        return cell;
    }else{
        IndexCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"IndexCell"  forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.globalIndexData = self.globalIndexData;
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSMutableArray *items = [NSMutableArray array];
    [items addObject: @"自选"];
    for (NSInteger i=0; i<self.moneyClassData.count; i++) {
        [items addObject:self.moneyClassData[i][@"value"]];
    }
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 26) titles:items delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    
//    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 26) titles:@[@"自选",@"基础链",@"社交通讯"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = [UIColor colorWithHex:@"#e6e6e7"];
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

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y - 64;
//    if (scrollView.contentOffset.y >= bottomCellOffset) {
//        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
//        if (self.canScroll) {
//            self.canScroll = NO;
//            self.contentCell.cellCanScroll = YES;
//        }
//    }else{
//        if (!self.canScroll) {//子视图没到顶部
//            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
//        }
//    }
//    self.tableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
}

#pragma mark LazyLoad
- (FSBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[FSBaseTableView alloc]initWithFrame:CGRectMake(0, LL_StatusBarAndNavigationBarHeight, UIScreenW, UIScreenH-LL_TabbarHeight -LL_StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        
        [_tableView registerClass:[GraphCell class] forCellReuseIdentifier:@"GraphCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"IndexCell" bundle:nil] forCellReuseIdentifier:@"IndexCell"];
        
    }
    return _tableView;
}

-(void)loadNewData{
    

    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tradePlatformID = [defaults objectForKey:@"tradePlatformID"];
    dict[@"tradePlatformID"] = tradePlatformID;
    [NetworkManage Get:globalIndex andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            self.globalIndexData = obj[@"data"];
            
            //指定刷新某行cell
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    [NetworkManage Get:moneyClass andParams:nil success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            self.moneyClassData = obj[@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    [self requestIndexSelectDatas:@"btc"];
}

#pragma mark 通知
-(void)indexTypeClick:(NSNotification *)notification{
    NSDictionary * infoDic = [notification object];
    NSLog(@"%@",infoDic[@"selectType"]);
    [self requestIndexSelectDatas:infoDic[@"selectType"]];
}

-(void)requestIndexSelectDatas:(NSString*)selectType{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPair"] = selectType;
    [NetworkManage Get:coinmarketcapHistory andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            
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
        
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *targetArray = [NSMutableArray array];
            [obj[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"historyDate"]];
                [targetArray addObject:obj[@"closePrice"]];
            }];
            
            NSLog(@"%d---%d",maxPriceSection,minPriceSection);
            self.IndexTypeViewDic[@"max"] = [NSString stringWithFormat:@"%d",maxPriceSection];
            self.IndexTypeViewDic[@"min"] = [NSString stringWithFormat:@"%d",minPriceSection];
            self.IndexTypeViewDic[@"xArray"] = xArray;
            self.IndexTypeViewDic[@"targetArray"] = targetArray;
            self.IndexTypeViewDic[@"selectType"] = selectType;
            
            //指定刷新某行cell
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
