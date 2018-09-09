//
//  DepthVC.m
//  Fairy
//
//  Created by 张恒 on 2018/8/25.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "DepthVC.h"
#import "DepthTitleCell.h"
#import "DepthBtnCell.h"
#import "SuperFastLineController.h"
#import "DepthWarningViewController.h"
#import "NewDepthDetailViewController.h"
#import "NewDXYCViewController.h"
#import "LoginVC.h"
@interface DepthVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) FSBaseTableView *tableView;
@property (nonatomic, assign) BOOL canScroll;


@end

@implementation DepthVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNewData];
    [self initNavtionBar];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.canScroll = YES;
    [self.view addSubview:self.tableView];
    
    [self loadNewData];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)initNavtionBar{
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    ItemLab.text = @"深度";
    ItemLab.textAlignment = NSTextAlignmentCenter;
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
}


#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return kScreenValue(103);
        
    }else{
        if (indexPath.row == 0) {
            return kScreenValue(45);
        }else{
            
            return kScreenValue(110);
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DepthTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DepthTitleCell"];
    DepthBtnCell *DepthBtnCell = [tableView dequeueReusableCellWithIdentifier:@"DepthBtnCell"];
    UITableViewCell *DefCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DepthBtnCell.selectionStyle = UITableViewCellSelectionStyleNone;
    DefCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section == 0) {
        
       
        
        switch (indexPath.row) {
            case 0:
                cell.title.text = @"超短线助手";
                cell.twoTitle.text = @"预测区间为6小时";

                cell.icon.image = [UIImage imageNamed:@"ChartUp"];
                break;
            case 1:
                cell.title.text = @"短线预测";
                cell.twoTitle.text = @"预测区间为1天";

                cell.icon.image = [UIImage imageNamed:@"Chart"];
                break;
            case 2:
                cell.title.text = @"预警中心";
                cell.twoTitle.text = @"相关性、预测、市场情感";

                cell.icon.image = [UIImage imageNamed:@"Antenna1"];
                break;
            default:
                break;
        }
        
        
        
//        
//        NSString *str = @"100MT/天";
//        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
//        // 赋值
//        cell.payForDay.attributedText = attribtStr;
        
        return cell;
        
    }else{
        
        if (indexPath.row == 0) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
            label.text = @"    工具箱";
            label.font = [UIFont systemFontOfSize:kScreenValue(17)];
            [DefCell.contentView addSubview:label];
            
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = RGBA(232, 239, 245, 1);
            [label addSubview:line];
            
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(label.mas_bottom).offset(10);
                make.left.right.equalTo(DefCell.contentView);
                make.height.mas_equalTo(kScreenValue(1));
            }];
            return DefCell;
            
        }else{
            return DepthBtnCell;
            
        }
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginStatus = [defaults objectForKey:@"loginStatus"];

    if ([loginStatus isEqualToString:@"未登录"]||[CommonTool isNullToString:loginStatus]) {
        LoginVC *vc =[LoginVC new];
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
        vc.hidesBottomBarWhenPushed = YES;
        [self presentViewController:nav animated:YES completion:nil];
    }else
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NewDepthDetailViewController *vc = [[NewDepthDetailViewController alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }else if (indexPath.row == 1) {
            NewDXYCViewController *vc = [[NewDXYCViewController alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }else{
            DepthWarningViewController *vc = [[DepthWarningViewController alloc]init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }
    }
    
}


//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


#pragma mark LazyLoad
- (FSBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[FSBaseTableView alloc]initWithFrame:CGRectMake(0, LL_StatusBarAndNavigationBarHeight, UIScreenW, UIScreenH-LL_TabbarHeight -LL_StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [_tableView registerClass:[DepthTitleCell class] forCellReuseIdentifier:@"DepthTitleCell"];
        [_tableView registerClass:[DepthBtnCell class] forCellReuseIdentifier:@"DepthBtnCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
        
    }
    return _tableView;
}
-(void)loadNewData{
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tradePlatformID = [defaults objectForKey:@"tradePlatformID"];
    dict[@"tradePlatformID"] = tradePlatformID;
    //    [NetworkManage Get:globalIndex andParams:dict success:^(id responseObject) {
    //        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
    //        if ([obj[@"code"] integerValue] ==200 ) {
    //            self.globalIndexData = obj[@"data"];
    //
    //            //指定刷新某行cell
    //            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    //            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    //        }
    //    } failure:^(NSError *error) {
    //        NSLog(@"%@",error);
    //    }];
    //
    //
    //
    //    [NetworkManage Get:moneyClass andParams:nil success:^(id responseObject) {
    //        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
    //        if ([obj[@"code"] integerValue] ==200 ) {
    //            self.moneyClassData = obj[@"data"];
    //            [self.tableView reloadData];
    //        }
    //    } failure:^(NSError *error) {
    //        NSLog(@"%@",error);
    //    }];
    //
    //    [self requestIndexSelectDatas:@"btc"];
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
