//
//  MyWalletVC.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/28.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "MyWalletVC.h"
#import "MyWalletCell.h"
#import "MyWalletDetailVC.h"
#import "ChangeWalletVC.h"
#import "ForgetWalletVC.h"
@interface MyWalletVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation MyWalletVC
-(NSMutableDictionary *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableDictionary dictionary];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor grayColor];
    [self initNavtionBar];
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}
-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"交易钱包";
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    
    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
}
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor =[UIColor colorWithHex:@"#e8f0f3"];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
        [_myTableView registerClass:[MyWalletCell class] forCellReuseIdentifier:@"MyWalletCell"];
        
    }
    return _myTableView;
}


#pragma mark UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return 3;
    }
    else {
        return 2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 168;
        }else{
            return 62;
        }
    }
    else {
        return 62;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor =[UIColor whiteColor];
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:@"我的钱包拷贝"];
            
            [cell addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView.mas_top).offset(8);
                make.left.equalTo(cell.contentView.mas_left).offset(15);
                make.width.mas_equalTo(kScreenWidth - 30);
                make.height.mas_equalTo(168 - 16);
                
            }];
            return cell;
            
        }else if(indexPath.row == 1){
            MyWalletCell *SetCell = [tableView dequeueReusableCellWithIdentifier:@"MyWalletCell" forIndexPath:indexPath];
            SetCell.selectionStyle = UITableViewCellSelectionStyleNone;
            SetCell.icon.image = [UIImage imageNamed:@"FYC"];
            SetCell.title.text = @"FYC";
            SetCell.count.text = [NSString stringWithFormat:@"%@",self.dataSource[@"remainCurrencyFYC"]];
            return SetCell;
            
        }else if(indexPath.row == 2){
            MyWalletCell *SetCell = [tableView dequeueReusableCellWithIdentifier:@"MyWalletCell" forIndexPath:indexPath];
            SetCell.selectionStyle = UITableViewCellSelectionStyleNone;
            SetCell.icon.image = [UIImage imageNamed:@"ETH"];
            SetCell.title.text = @"ETH";
            SetCell.count.text = [NSString stringWithFormat:@"%@",self.dataSource[@"remainCurrency"]];
            return SetCell;
            
        }else{
            return nil;
            
        }
        
    }else{
        MyWalletCell *SetCell = [tableView dequeueReusableCellWithIdentifier:@"MyWalletCell" forIndexPath:indexPath];
        SetCell.selectionStyle = UITableViewCellSelectionStyleNone;
        SetCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0)
        {
            SetCell.icon.image = [UIImage imageNamed:@"AppIcon"];
            SetCell.title.text = @"修改密码";
            SetCell.count.text = @"";
            
        }else{
            SetCell.icon.image = [UIImage imageNamed:@"AppIcon"];
            SetCell.title.text = @"忘记密码";
            SetCell.count.text = @"";
            
        }
        return SetCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        MyWalletDetailVC *vc =[MyWalletDetailVC new];
        vc.hidesBottomBarWhenPushed = YES;
        if (indexPath.row == 1) {
            vc.title = @"FYC";
        }
        else if (indexPath.row == 2) {
        
            vc.title = @"ETH";
        }
        vc.Data = self.dataSource;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (indexPath.row == 0) {
            ChangeWalletVC *vc =[ChangeWalletVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            ForgetWalletVC *vc =[ForgetWalletVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
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
