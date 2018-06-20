//
//  HomeVC.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "HomeVC.h"
#import "FSScrollContentView.h"//三方头文件
#import "FSBaseTableView.h"
#import "FSBottomTableViewCell.h"
#import "HomeSubVC.h"
#import "IndexCellCell.h"
#import "GraphCell.h"
#import "SSSearchBar.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSBaseTableView *tableView;
@property (nonatomic, strong) FSBottomTableViewCell *contentCell;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, assign) BOOL canScroll;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
      
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatSearchBar];
    [self setupSubViews];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
    // Do any additional setup after loading the view.
}

-(void)creatSearchBar{
    SSSearchBar *searchBar = [[SSSearchBar alloc] initWithFrame:CGRectMake(0, 0, 260, 34)];
    searchBar.placeholder = @"搜索 平台/币种/资讯";
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 34)];
//    view.backgroundColor =[UIColor grayColor];
//    view.alpha = 0.5;
//    view.layer.cornerRadius = 17;
//    view.layer.masksToBounds = YES;
    [view addSubview:searchBar];
    self.navigationItem.titleView = view;
}

- (void)setupSubViews
{
    self.canScroll = YES;
    [self.view addSubview:self.tableView];


    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
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
            return 158;
        }else{
            return 140;
        }
        
    }
    return CGRectGetHeight(self.view.bounds);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!_contentCell) {
            _contentCell = [[FSBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            NSArray *titles = @[@"自选",@"基础链",@"社交通讯"];
            NSMutableArray *contentVCs = [NSMutableArray array];
            //            for (NSString *title in titles) {
            //                FSScrollContentViewController *vc = [[FSScrollContentViewController alloc]init];
            //                vc.title = title;
            //                vc.str = title;
            //                [contentVCs addObject:vc];
            //            }
            
            [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HomeSubVC*vc = [[HomeSubVC alloc]init];
                vc.title = obj;
//                vc.str = obj;
                [contentVCs addObject:vc];
            }];
            
            _contentCell.viewControllers = contentVCs;
            _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH  -LL_TabbarHeight) childVCs:contentVCs parentVC:self delegate:self];
            [_contentCell.contentView addSubview:_contentCell.pageContentView];
        }
        return _contentCell;
    }
    if (indexPath.row == 0) {
        IndexCellCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"IndexCellCell"  forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        GraphCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GraphCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 26) titles:@[@"自选",@"基础链",@"社交通讯"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = [UIColor colorWithHex:@"#e6e6e7"];
    self.titleView.titleSelectFont = AdaptedFontSize(33);
    self.titleView.titleSelectColor = [UIColor colorWithHex:@"#0e5f9f"];
    self.titleView.titleNormalColor = [UIColor colorWithHex:@"#000000"];
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
        _tableView = [[FSBaseTableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH-LL_TabbarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        
        [_tableView registerClass:[GraphCell class] forCellReuseIdentifier:@"GraphCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"IndexCellCell" bundle:nil] forCellReuseIdentifier:@"IndexCellCell"];
        
    }
    return _tableView;
}

-(void)loadNewData{
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
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
