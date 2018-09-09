//
//  MyWalletDetailVC.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/29.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "MyWalletDetailVC.h"
#import "WallentDJCell.h"
#import "GetCoinVC.h"
#import "ReceiveCoinVC.h"
#import "WalletListVC.h"
#import "MyWalletCell.h"
#import "MyWalletDetailListVC.h"

@interface MyWalletDetailVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation MyWalletDetailVC
-(NSMutableDictionary *)Data{
    if (!_Data) {
        _Data = [NSMutableDictionary dictionary];
    }
    return _Data;
}
- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor grayColor];
    [self initNavtionBar];
    [self.view addSubview:self.myTableView];
    // Do any additional setup after loading the view.
}


-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = self.title;
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
        
        [_myTableView registerClass:[WallentDJCell class] forCellReuseIdentifier:@"WallentDJCell"];
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
        return 2;
    }
    else {
        return 3;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 168;
        }else{
            return 82;
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
            cell.backgroundColor =RGBA(232, 239, 245, 1);
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
            WallentDJCell *SetCell = [tableView dequeueReusableCellWithIdentifier:@"WallentDJCell" forIndexPath:indexPath];
            SetCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if ([self.title isEqualToString:@"FYC"]) {
                SetCell.icon.image = [UIImage imageNamed:@"FYC"];
                SetCell.title.text = @"FYC";
                SetCell.keyong.text = [NSString stringWithFormat:@"可用:%@",self.Data[@"remainCurrencyFYC"]];
                SetCell.dongjie.text = [NSString stringWithFormat:@"冻结:%@",self.Data[@"lockCurrencyFYC"]];
            }else
            {
                SetCell.icon.image = [UIImage imageNamed:@"ETH"];
                SetCell.title.text = @"ETH";
                SetCell.keyong.text = [NSString stringWithFormat:@"可用:%@",self.Data[@"remainCurrency"]];
                SetCell.dongjie.text = [NSString stringWithFormat:@"冻结:%@",self.Data[@"lockCurrency"]];
            }

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
            SetCell.icon.image = [UIImage imageNamed:@"88"];
            SetCell.title.text = @"提币";
            SetCell.count.text = @"";
            
        }else  if (indexPath.row == 1)
        {
            SetCell.icon.image = [UIImage imageNamed:@"9"];
            SetCell.title.text = @"接收";
            SetCell.count.text = @"";
            
        }
        else{
            SetCell.icon.image = [UIImage imageNamed:@"8"];
            SetCell.title.text = @"明细";
            SetCell.count.text = @"";
            
        }
        return SetCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
    }else{
        if (indexPath.row == 0) {
            GetCoinVC *vc =[GetCoinVC new];
            vc.title = self.title;
            vc.data = self.Data;
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row == 1){
            PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
            NSMutableDictionary *dict =[NSMutableDictionary dictionary];
            dict[@"token"]  = userModel.token;
            NSString *str = [NSString stringWithFormat:@"%@?token=%@",WalletRecharge,dict[@"token"]];
            ReceiveCoinVC *vc =[ReceiveCoinVC new];
            vc.title = self.title;

            [NetworkManage Get:str andParams:nil success:^(id responseObject) {
                NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
                if ([obj[@"code"] integerValue] == 200) {
                    vc.data = obj[@"data"];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    [self showHint:responseObject[@"message"]];
                    
                }
                
                
                
            } failure:^(NSError *error) {
                [self showHint:@"网络有错误"];
            }];
            
        }
        else{
            
            
            MyWalletDetailListVC *vc =[MyWalletDetailListVC new];
            vc.title = self.title;
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

@end
