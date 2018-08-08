//
//  InformationSubVC.m
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 . All rights reserved.
//

#import "InformationSubVC.h"
#import "InformationCell.h"
#import "InformationModel.h"
#import "InformationFrameModel.h"
#import "InformationDetailsVC.h"


@interface InformationSubVC ()<UITableViewDataSource, UITableViewDelegate,InformationCellDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray * informationFrameModelArr;

@property(nonatomic,assign)NSInteger allNumber;
@property(nonatomic,assign)NSInteger currentPage;


@end

@implementation InformationSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.myTableView];
 
    self.informationFrameModelArr = [NSMutableArray array];
    //下拉刷新
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDatas)];
    [self.myTableView.mj_header beginRefreshing];
    
    // 加载更多
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestMoreDatas];
    }];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.headType);
}
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - LL_StatusBarAndNavigationBarHeight -LL_TabbarHeight - 30) style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[InformationCell class] forCellReuseIdentifier:@"InformationCell"];
        //        self.automaticallyAdjustsScrollViewInsets = NO;//解决tableview头部预留64像素的办法
    }
    return _myTableView;
}

#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.informationFrameModelArr.count;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    InformationFrameModel *model = self.informationFrameModelArr[indexPath.row];
    return model.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InformationCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"InformationCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.informationFrameModel = self.informationFrameModelArr[indexPath.row];
    cell.delegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark InformationDelegate
-(void)urlclick:(InformationCell *)informationCellCell{
    NSIndexPath *index = [self.myTableView indexPathForCell:informationCellCell];
    InformationFrameModel *informationFrameModel = self.informationFrameModelArr[index.row];
    InformationDetailsVC *vc =[InformationDetailsVC new];
    vc.url = informationFrameModel.informationModel.url;
    vc.hidesBottomBarWhenPushed = YES;
    [[Tool getCurrentVC].navigationController pushViewController:vc animated:YES];
}



-(void)requestDatas{
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if ([self.headType isEqualToString:@"中文"]) {
        dict[@"lang"] = @"cn";
    }
    else{
        dict[@"lang"] = @"en";
    }
    self.currentPage = 1;
    dict[@"pager.pageNo"] = [NSString stringWithFormat:@"%ld",(long)self.currentPage];
    
    
    /// 发送请求
    __weak InformationSubVC *weakSelf = self;
    [NetworkManage Get:Information andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        weakSelf.allNumber = [obj[@"pager.totalRows"] integerValue];
        NSArray *aryModel  = [InformationModel mj_objectArrayWithKeyValuesArray:obj[@"rows"]];
        // 将InformationModel数组模型转换成InformationFrameModel数组模型
        NSMutableArray *informationFrameModelArr = [weakSelf informationFrameModelWithInformationModel:aryModel];
        [weakSelf.informationFrameModelArr removeAllObjects];
        [weakSelf.informationFrameModelArr addObjectsFromArray:informationFrameModelArr];
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.myTableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];

}

-(void)requestMoreDatas{
    
    if (self.informationFrameModelArr.count >= self.allNumber) {
        [self.myTableView.mj_footer endRefreshing];
        return;
    }

    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    if ([self.headType isEqualToString:@"中文"]) {
        dict[@"lang"] = @"cn";
    }
    else{
        dict[@"lang"] = @"en";
    }
    self.currentPage++;
    NSLog(@"%ld",self.currentPage);
    dict[@"pager.pageNo"] = [NSString stringWithFormat:@"%ld",(long)self.currentPage];
    /// 发送请求
    __weak InformationSubVC *weakSelf = self;
    [NetworkManage Get:Information andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        NSArray *aryModel  = [InformationModel mj_objectArrayWithKeyValuesArray:obj[@"rows"]];
        // 将InformationModel数组模型转换成InformationFrameModel数组模型
        NSMutableArray *informationFrameModelArr = [weakSelf informationFrameModelWithInformationModel:aryModel];
        [weakSelf.informationFrameModelArr addObjectsFromArray:informationFrameModelArr];;
        [weakSelf.myTableView.mj_footer endRefreshing];
        [weakSelf.myTableView reloadData];
    } failure:^(NSError *error) {
        [self.myTableView.mj_footer endRefreshing];
        NSLog(@"%@",error);
    }];
    
}


- (NSMutableArray *)informationFrameModelWithInformationModel :(NSArray *)aryModel
{
    NSMutableArray *informationFrameModelArr = [NSMutableArray array];
    for (InformationModel *informationModel in aryModel) {
        InformationFrameModel *informationFrameModel = [[InformationFrameModel alloc]init];
        informationFrameModel.informationModel = informationModel;
        [informationFrameModelArr addObject:informationFrameModel];
    }
    return informationFrameModelArr;
    
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
