//
//  MineVC.m
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "MineVC.h"
#import "HeadView.h"
#import "SettingCell.h"

#import "LoginVC.h"
#import "PersionDetailVC.h"
#import "PriceCenterVC.h"
#import "WarnCenterVC.h"
#import "MemberVC.h"
#import "GeneralVC.h"
#import "ShareVC.h"
#import "MyWalletVC.h"


@interface MineVC ()<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) HeadView *headView;
@end

@implementation MineVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [self requestData];
    [self.headView updateUserInfo];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -LL_StatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-LL_TabbarHeight + LL_StatusBarHeight) style:UITableViewStylePlain];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor =[UIColor colorWithHex:@"#f1f2f4"];
        [_myTableView registerNib:[UINib nibWithNibName:@"HeadCell" bundle:nil] forCellReuseIdentifier:@"HeadCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"SettingCell" bundle:nil] forCellReuseIdentifier:@"SettingCell"];
        //        self.automaticallyAdjustsScrollViewInsets = NO;//解决tableview头部预留64像素的办法
        
        HeadView *headView=[[HeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 162+ LL_StatusBarHeight)];
        self.headView = headView;
        headView.delegate =self;
        _myTableView.tableHeaderView = headView;
        
    }
    return _myTableView;
}

#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else{
         return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineView.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    if (  indexPath.row == 1  )
    {
        cell.lineView.hidden = YES;
    }else
    {
        cell.lineView.hidden = NO;
    }
    
    if (indexPath.section==0) {
        if (indexPath.row == 0)
        {
            cell.logoIM.image = [UIImage imageNamed:@"icon_Quote-center"];
            cell.nameLab.text = @"行情中心";
            cell.detailLab.text = @"";
        }
        else if (indexPath.row == 1)
        {
            cell.logoIM.image = [UIImage imageNamed:@"icon_Warning"];
            cell.nameLab.text = @"预警中心";
            cell.detailLab.text = @"";
            cell.lineView.hidden = NO;

        }
        else if (indexPath.row == 2)
        {
            cell.logoIM.image = [UIImage imageNamed:@"icon_Warning"];
            cell.nameLab.text = @"我的钱包";
            cell.detailLab.text = @"";
        }
    }else if (indexPath.section==1){
        if (indexPath.row == 0)
        {
            cell.logoIM.image = [UIImage imageNamed:@"icon_General-settings"];
            cell.nameLab.text = @"通用设置";
            cell.detailLab.text = @"";
        }
        else if (indexPath.row == 1)
        {
            cell.logoIM.image = [UIImage imageNamed:@"icon_Share application"];
            cell.nameLab.text = @"分享应用";
            cell.detailLab.text = @"";
        }
    }
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0){
        if (indexPath.row ==0) {
            PriceCenterVC *vc =[PriceCenterVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==1){
            WarnCenterVC *vc =[WarnCenterVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==2){
            MyWalletVC *vc =[MyWalletVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section==1){
        if (indexPath.row==0){
            GeneralVC *vc =[GeneralVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==1){
            ShareVC* vc =[ShareVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 40)];
    view.backgroundColor =[UIColor whiteColor];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 40)];
    lab.textColor =[UIColor colorWithHex:@"#000000"];
    lab.font =AdaptedFontSize(30);
    if (section==0) {
        lab.text=@"个人设置";
    }else if (section==1){
        lab.text=@"系统设置";
    }
    [view addSubview:lab];
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 39, UIScreenW, 1)];
    lineView.backgroundColor =[UIColor colorWithHex:@"#cccccc"];;
    [view addSubview:lineView];
    
    return view;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 10)];
    view.backgroundColor =[UIColor colorWithHex:@"#f2f2f2"];
    return view;
}
#define mark HeadViewDelegate
-(void)headViewLoginTapClick{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loginStatus = [defaults objectForKey:@"loginStatus"];
    if ([loginStatus isEqualToString:@"已登录"]) {
        PersionDetailVC *vc=[PersionDetailVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        LoginVC *vc =[LoginVC new];
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
        vc.hidesBottomBarWhenPushed = YES;
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}


-(void)nightModeClick:(UIButton*)btn{
    btn.selected = !btn.selected;
}

-(void)requestData{
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    dict[@"consumerID"] = userModel.consumerID;
    
    NSString *path =[NSString stringWithFormat:@"%@?token=%@",consumerView,userModel.token];
    
    [NetworkManage Get:path andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            NSLog(@"%@",obj[@"data"]);
            /*
             {
             appVersion = "<null>";
             birthday = "<null>";
             checkCode = "<null>";
             cityID = "<null>";
             consumerID = 46;
             consumerName = "<null>";
             consumerRankID = 1;
             deviceName = "<null>";
             deviceNumber = "<null>";
             email = "<null>";
             fairycoinID = 9860065;
             gender = "<null>";
             headerPic = "<null>";
             lastLoginTime = 1534328537000;
             loginName = zhangsan;
             nickname = "<null>";
             password = 02C75FB22C75B23DC963C7EB91A062CC;
             phoneNumber = 18612956645;
             platform = "<null>";
             provinceID = "<null>";
             token = "zhangsan_1382b9838d8442ce94a9b86fa402e25b";
             userID = "<null>";
             }
             */
        }
    } failure:^(NSError *error) {
        NSLog(@"网络有问题");
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
