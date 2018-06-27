//
//  MineVC.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "MineVC.h"
#import "HeadCell.h"
#import "SettingCell.h"

#import "PersionDetailVC.h"
#import "PriceCenterVC.h"
#import "WarnCenterVC.h"
#import "MemberVC.h"
#import "GeneralVC.h"
#import "ShareVC.h"

@interface MineVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
//@property (nonatomic, copy)NSArray *dataArr;

@end

@implementation MineVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
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
    }
    return _myTableView;
}

#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 1;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 165+LL_StatusBarHeight;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        HeadCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"HeadCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==2&&indexPath.row==0){
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"ExitCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExitCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor =[UIColor whiteColor];
            
            UIImageView *logoIM=[UIImageView new];
            [cell.contentView addSubview:logoIM];
            logoIM.image=[UIImage imageNamed:@"nightMode"];
            [logoIM mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(12);
                make.width.mas_equalTo(20);
                make.height.mas_equalTo(20);
                make.centerY.mas_equalTo(cell.contentView);
            }];
            
            UILabel *titleLab=[UILabel new];
            [cell.contentView addSubview:titleLab];
            titleLab.text = @"夜间模式";
            titleLab.backgroundColor = [UIColor whiteColor];
            titleLab.font = AdaptedFontSize(30);
            titleLab.textColor = [UIColor colorWithHex:@"#000000"];
            titleLab.textAlignment = NSTextAlignmentLeft;
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(logoIM.mas_right).offset(12);
                make.width.mas_equalTo(120);
                make.height.mas_equalTo(22);
                make.centerY.mas_equalTo(cell.contentView);
            }];
            
            //开关
            UIButton* nightModelBtn =[UIButton new];
            [cell.contentView addSubview:nightModelBtn];
            nightModelBtn.selected = NO;
            [nightModelBtn setImage:[UIImage imageNamed:@"nightMode_close"] forState:UIControlStateNormal];
            [nightModelBtn setImage:[UIImage imageNamed:@"nightMode_open"] forState:UIControlStateSelected];
            [nightModelBtn addTarget:self action:@selector(nightModeClick:) forControlEvents:UIControlEventTouchUpInside];
            [nightModelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
                make.width.mas_equalTo(50);
                make.height.mas_equalTo(24);
                make.centerY.mas_equalTo(cell.contentView);
            }];
            
            
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
            [cell.contentView addSubview:lineView];
            lineView.frame =CGRectMake(0, CGRectGetMaxY(cell.contentView.frame), UIScreenW, AdaptedHeight(1));
            
        }
        
        return cell;
    }
    else{
        SettingCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineView.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
        if (  indexPath.row == 2  )
        {
            cell.lineView.hidden = YES;
        }else
        {
            cell.lineView.hidden = NO;
        }

        if (indexPath.section==1) {
            if (indexPath.row == 0)
            {
                cell.logoIM.image = [UIImage imageNamed:@"price"];
                cell.nameLab.text = @"行情中心";
                cell.detailLab.text = @"";
        
            }
            else if (indexPath.row == 1)
            {
                cell.logoIM.image = [UIImage imageNamed:@"warn"];
                cell.nameLab.text = @"预警中心";
                cell.detailLab.text = @"";
            }
            else if (indexPath.row == 2)
            {
                cell.logoIM.image = [UIImage imageNamed:@"member"];
                cell.nameLab.text = @"会员中心";
                cell.detailLab.text = @"";
            }
        }else if (indexPath.section==2){
            if (indexPath.row == 1)
            {
                cell.logoIM.image = [UIImage imageNamed:@"generalSettings"];
                cell.nameLab.text = @"通用设置";
                cell.detailLab.text = @"";
            }
            else if (indexPath.row == 2)
            {
                cell.logoIM.image = [UIImage imageNamed:@"appShare"];
                cell.nameLab.text = @"分享应用";
                cell.detailLab.text = @"";
            }
        }
       
        return cell;
    }
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc;
    if (indexPath.section==0) {
        vc =[PersionDetailVC new];
    }
    else if (indexPath.section==1){
        if (indexPath.row ==0) {
            vc =[PriceCenterVC new];
        }
        else if (indexPath.row==1){
            vc =[WarnCenterVC new];
        }
        else if (indexPath.row==2){
            vc =[MemberVC new];
        }
    }
    else if (indexPath.section==2){
        if (indexPath.row ==0) {
            
        }
        else if (indexPath.row==1){
            vc =[GeneralVC new];
        }
        else if (indexPath.row==2){
            vc =[ShareVC new];
        }
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 0;
    }
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 40)];
    view.backgroundColor =[UIColor whiteColor];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 40)];
    lab.textColor =[UIColor colorWithHex:@"#000000"];
    lab.font =AdaptedFontSize(30);
    if (section==1) {
        lab.text=@"个人设置";
    }else if (section==2){
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



-(void)nightModeClick:(UIButton*)btn{
    btn.selected = !btn.selected;
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
