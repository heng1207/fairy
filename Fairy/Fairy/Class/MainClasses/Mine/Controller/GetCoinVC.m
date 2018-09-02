//
//  GetCoinVC.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/29.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "GetCoinVC.h"
#import "HQLConst.h"
#import "UIView+Extension.h"
#import "HQLPasswordView.h"
#import "ForgetWalletVC.h"


@interface GetCoinVC ()<UITextFieldDelegate>
//naviview
@property (nonatomic, strong) UIView *naviView;
//phonetf
@property (nonatomic, strong) UITextField *phoneTF;
//passwordtf
@property (nonatomic, strong) UITextField *codeTF;
//passwordtf
@property (nonatomic, strong) UITextField *NewPassTF;

//codeLoginBtn
@property (nonatomic, strong) UIButton *codeLoginBtn;
//registerBtn
@property (nonatomic, strong) UIButton *registerBtn;
//codeBtn
@property (nonatomic, strong) UIButton *codeBtn;
//loginBtn
@property (nonatomic, strong) UIButton *loginBtn;
/** 倒计时 */
@property (nonatomic, assign) unsigned secondsCountDown;
/** 定时器 */
@property (nonatomic, weak) NSTimer *countDownTimer;
//手机号
@property (nonatomic, copy) NSString *phoneStr;
//验证码
@property (nonatomic, copy) NSString *codeStr;

@property (nonatomic, strong) HQLPasswordView *passwordView;

@end

@implementation GetCoinVC
static BOOL flag = NO;
static const CGFloat kRequestTime = 3.0f;
static const CGFloat KDelay = 2.0f;

-(NSMutableDictionary *)data{
    if(!_data){
        _data = [NSMutableDictionary dictionary];
    }
    return _data;
}
- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor grayColor];
    [self initNavtionBar];
    [self createCodeLoginView];
    self.view.backgroundColor = RGBA(232,239, 245, 1);
    [self getPassView];
    // Do any additional setup after loading the view.
}

-(void)getPassView{
    PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"token"]  = userModel.token;
    NSString *res = [NSString stringWithFormat:@"%@?token=%@",HasPayPassword,dict[@"token"]];
    
    [NetworkManage Get:res andParams:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
           
            if ([obj[@"data"] integerValue] == 1) {
                flag = YES;
                
            }else{
                flag = NO;
                [self setPassView];
                
            }
            
        }else {
            [self showHint:obj[@"message"]];
        }

        
        
        
    } failure:^(NSError *error) {
        [self showHint:@"网络错误"];
    }];
    
}

-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = [NSString stringWithFormat:@"提币-%@",self.title];
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
#pragma mark - pravite method
- (void)createCodeLoginView
{
    UIView *backView = [[UILabel alloc] init];
    backView.userInteractionEnabled = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(18+60);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(kScreenValue(152));
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textColor = [UIColor similarBlackColor];
    phoneLabel.text = @"可用";
    phoneLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(kScreenValue(17));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(16));
        make.width.mas_equalTo(kScreenValue(55));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.textColor = [UIColor similarBlackColor];
    
    if ([self.title isEqualToString:@"ETH"]) {
        countLabel.text = [NSString stringWithFormat:@"%@",self.data[@"remainCurrency"]];

    }else{
        countLabel.text = [NSString stringWithFormat:@"%@",self.data[@"remainCurrencyFYC"]];

    }
    
    countLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:countLabel];
    
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel);
        make.left.equalTo(phoneLabel.mas_right).offset(kScreenValue(22));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-30));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor similarLightGrayColor];
    [backView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countLabel.mas_bottom).offset(kScreenValue(17));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(0));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(0));
        make.height.mas_equalTo(kScreenValue(1));
    }];
    
    UILabel *NewPasswordLabel = [[UILabel alloc] init];
    NewPasswordLabel.textColor = [UIColor similarBlackColor];
    NewPasswordLabel.text = @"地址";
    NewPasswordLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:NewPasswordLabel];
    [NewPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(kScreenValue(17));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(16));
        make.width.mas_equalTo(kScreenValue(55));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    [backView addSubview:self.NewPassTF];
    [self.NewPassTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(NewPasswordLabel);
        make.left.equalTo(NewPasswordLabel.mas_right).offset(kScreenValue(22));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-30));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor similarLightGrayColor];
    [backView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.NewPassTF.mas_bottom).offset(kScreenValue(17));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(0));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(0));
        make.height.mas_equalTo(kScreenValue(1));
    }];
    

    UILabel *GetCount = [[UILabel alloc] init];
    GetCount.textColor = [UIColor similarBlackColor];
    GetCount.text = @"数量";
    GetCount.font = [UIFont systemFontOfSize:14];
    [backView addSubview:GetCount];
    [GetCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(kScreenValue(17));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(16));
        make.width.mas_equalTo(kScreenValue(55));
        make.height.mas_equalTo(kScreenValue(14));
    }];

    [backView addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(kScreenValue(17));
        make.left.equalTo(GetCount.mas_right).offset(kScreenValue(22));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-30));
        make.height.mas_equalTo(kScreenValue(14));
    }];

    
    
//    //第二区
//
    UIView *backView2 = [[UILabel alloc] init];
    backView2.userInteractionEnabled = YES;
    backView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(8);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(kScreenValue(48));
    }];
//
//
    UILabel *absenteeism = [[UILabel alloc] init];
    absenteeism.textColor = [UIColor similarBlackColor];
    absenteeism.text = @"矿工费";
    absenteeism.font = [UIFont systemFontOfSize:14];
    [backView2 addSubview:absenteeism];
    [absenteeism mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView2.mas_top).offset(kScreenValue(17));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(16));
        make.width.mas_equalTo(kScreenValue(55));
        make.height.mas_equalTo(kScreenValue(14));
    }];

    UILabel *absenteeismCount = [[UILabel alloc] init];
    absenteeismCount.textColor = [UIColor similarBlackColor];
    absenteeismCount.text = @"0";
    absenteeismCount.font = [UIFont systemFontOfSize:14];
    [backView2 addSubview:absenteeismCount];
    [absenteeismCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(absenteeism);
        make.left.equalTo(absenteeism.mas_right).offset(kScreenValue(22));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-30));
        make.height.mas_equalTo(kScreenValue(14));
    }];

    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView2.mas_bottom).offset(kScreenValue(30));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(14));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-14));
        make.height.mas_equalTo(kScreenValue(47));
    }];
    
    
    
    
}
-(void)setPassView{
    WS(weakself);
    self.passwordView = [[HQLPasswordView alloc] init];
    [self.passwordView showInView:self.view.window];
    self.passwordView.title = @"设置支付密码";
    self.passwordView.loadingText = @"正在提交中...";
    self.passwordView.closeBlock = ^{
        NSLog(@"取消支付回调...");
    };
    self.passwordView.forgetPasswordBlock = ^{
        NSLog(@"忘记密码回调...");
        
        ForgetWalletVC *vc = [ForgetWalletVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vc animated:YES];
        
    };
    self.passwordView.finishBlock = ^(NSString *password) {
        NSLog(@"完成支付回调...");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kRequestTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
            NSMutableDictionary *dict =[NSMutableDictionary dictionary];
            dict[@"token"]  = userModel.token;
            NSString *str = [NSString stringWithFormat:@"%@?token=%@",setPayPassword, dict[@"token"]];
            
            NSDictionary *dic = @{@"payPassword":password};
            
            [NetworkManage Post:str andParams:dic success:^(id responseObject) {
                
                [weakself.passwordView requestComplete:YES message:@"设置成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( KDelay* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 从父视图移除密码输入视图
                    [weakself.passwordView removePasswordView];
                });
                
                
                
            } failure:^(NSError *error) {
                [weakself showHint:@"网络错误"];
            }];
        });
    };
    
}

- (void)loginAction:(UIButton *)sender
{
    if (self.NewPassTF.text.length != 11)
    {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showInfoWithStatus:@"请输入11位手机号码"];
    }
  
    else
    {
        
    }
    WS(weakself);
    self.passwordView = [[HQLPasswordView alloc] init];
    [self.passwordView showInView:self.view.window];
    self.passwordView.title = @"我是标题";
    self.passwordView.loadingText = @"正在支付中...";
    self.passwordView.closeBlock = ^{
        NSLog(@"取消支付回调...");
    };
    self.passwordView.forgetPasswordBlock = ^{
        NSLog(@"忘记密码回调...");
        
        ForgetWalletVC *vc = [ForgetWalletVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:vc animated:YES];
        
    };
    self.passwordView.finishBlock = ^(NSString *password) {
        NSLog(@"完成支付回调...");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kRequestTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
            NSMutableDictionary *dict =[NSMutableDictionary dictionary];
            dict[@"token"]  = userModel.token;
            NSString *str = [NSString stringWithFormat:@"%@?token=%@",verifyPayPassword, dict[@"token"]];
            
            NSDictionary *dic = @{@"payPassword":password};
            
            [NetworkManage Post:str andParams:dic success:^(id responseObject) {
                
                [weakself.passwordView requestComplete:YES message:@"购买成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( KDelay* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 从父视图移除密码输入视图
                    [weakself.passwordView removePasswordView];
                    
                    
                    //提币
                    NSString *str = [NSString stringWithFormat:@"%@?token=%@",sendToAddress, dict[@"token"]];
                    NSDictionary *dic = @{@"toAddr":@"dadasdasdasdasdas",
                                          @"amount":self.codeTF,
                                          @"payPassword":password
                                          };

                    [NetworkManage Post:str andParams:dic success:^(id responseObject) {
                        
                        [weakself.passwordView requestComplete:YES message:@"购买成功"];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( KDelay* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [weakself.passwordView requestComplete:YES message:@"提币成功"];
                            
                        });
                    } failure:^(NSError *error) {
                        [weakself.passwordView requestComplete:YES message:@"提币失败"];
                    }];

                });
                
                
            } failure:^(NSError *error) {
                [weakself showHint:@"网络错误"];
            }];
        });
    };
    
    
    
}



- (void)countDownTimeWithSeconds:(NSTimer*)timerInfo
{
    if (self.secondsCountDown == 0)
    {
        [self.codeBtn setEnabled:YES];
        
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.countDownTimer invalidate];
    }
    else
    {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"剩余%@s",[[NSNumber numberWithInt:self.secondsCountDown] description]] forState:UIControlStateNormal];
        self.secondsCountDown--;
    }
}

- (void)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldValueChange
{
    if (self.NewPassTF.text.length != 0 && self.codeTF.text.length != 0)
    {
        self.loginBtn.enabled = YES;
        self.loginBtn.backgroundColor = [UIColor mainBlueColor];
    }
    else
    {
        self.loginBtn.enabled = NO;
        self.loginBtn.backgroundColor = [UIColor mainBlueColorEnable];
    }
}


- (UITextField *)phoneTF
{
    if (!_phoneTF)
    {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.textColor = [UIColor similarBlackColor];
        _phoneTF.font = [UIFont systemFontOfSize:14];
        _phoneTF.placeholder = @"请输入手机号";
        UIColor *color = [UIColor similarLightGrayColor];
        [_phoneTF setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        [_phoneTF addTarget:self action:@selector(textFieldValueChange) forControlEvents:UIControlEventEditingChanged];
        _phoneTF.delegate = self;
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTF;
}

- (UITextField *)codeTF
{
    if (!_codeTF)
    {
        _codeTF = [[UITextField alloc] init];
        _codeTF.textColor = [UIColor similarBlackColor];
        _codeTF.font = [UIFont systemFontOfSize:14];
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
        _codeTF.placeholder = @"请输入验证码";
        UIColor *color = [UIColor similarLightGrayColor];
        [_codeTF setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        [_codeTF addTarget:self action:@selector(textFieldValueChange) forControlEvents:UIControlEventEditingChanged];
        _codeTF.delegate = self;
    }
    return _codeTF;
}
- (UITextField *)NewPassTF
{
    if (!_NewPassTF)
    {
        _NewPassTF = [[UITextField alloc] init];
        _NewPassTF.textColor = [UIColor similarBlackColor];
        _NewPassTF.font = [UIFont systemFontOfSize:14];
        _NewPassTF.keyboardType = UIKeyboardTypeNumberPad;
        _NewPassTF.placeholder = @"请输入新密码";
        UIColor *color = [UIColor similarLightGrayColor];
        [_NewPassTF setValue:color forKeyPath:@"_placeholderLabel.textColor"];
        [_NewPassTF addTarget:self action:@selector(textFieldValueChange) forControlEvents:UIControlEventEditingChanged];
        _NewPassTF.delegate = self;
    }
    return _NewPassTF;
}



- (UIButton *)codeBtn
{
    if (!_codeBtn)
    {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeBtn setBackgroundColor:RGBA(18, 150, 219, 1) forState:UIControlStateNormal];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_codeBtn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
        _codeBtn.layer.masksToBounds = YES;
        _codeBtn.layer.cornerRadius = 5;
    }
    return _codeBtn;
}

- (UIButton *)loginBtn
{
    if (!_loginBtn)
    {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"确认提币" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor mainBlueColorEnable];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.cornerRadius = kScreenValue(5);
        _loginBtn.adjustsImageWhenHighlighted = NO;
        _loginBtn.enabled = NO;
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
    }
    return _loginBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
