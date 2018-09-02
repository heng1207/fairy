//
//  ChangeWalletVC.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/29.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "ChangeWalletVC.h"

@interface ChangeWalletVC ()<UITextFieldDelegate>
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


@end

@implementation ChangeWalletVC

- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor grayColor];
    [self initNavtionBar];
    [self createCodeLoginView];
    [self.view setUserInteractionEnabled: YES];
    self.view.backgroundColor = RGBA(232,239, 245, 1);
    
    // Do any additional setup after loading the view.
}
-(void)initNavtionBar{
    
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"修改密码";
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
    phoneLabel.text = @"输入密码";
    phoneLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(kScreenValue(17));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(16));
        make.width.mas_equalTo(kScreenValue(55));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    [backView addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel);
        make.left.equalTo(phoneLabel.mas_right).offset(kScreenValue(22));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-30));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor similarLightGrayColor];
    [backView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTF.mas_bottom).offset(kScreenValue(17));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(0));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(0));
        make.height.mas_equalTo(kScreenValue(1));
    }];
    
    
    
    UILabel *NewPasswordLabel = [[UILabel alloc] init];
    NewPasswordLabel.textColor = [UIColor similarBlackColor];
    NewPasswordLabel.text = @"确认密码";
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
    
    
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.textColor = [UIColor similarBlackColor];
    passwordLabel.text = @"短信验证码";
    passwordLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(kScreenValue(17));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(16));
        make.width.mas_equalTo(kScreenValue(65));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    [backView addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordLabel);
        make.left.equalTo(passwordLabel.mas_right).offset(kScreenValue(22));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-110));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    [backView addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(kScreenValue(7));
        make.left.equalTo(self.codeTF.mas_right);
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-30));
        make.height.mas_equalTo(kScreenValue(33));
        make.width.mas_equalTo(kScreenValue(101));
        
    }];

    
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset(kScreenValue(59));
        make.left.equalTo(self.view.mas_left).offset(kScreenValue(14));
        make.right.equalTo(self.view.mas_right).offset(kScreenValue(-14));
        make.height.mas_equalTo(kScreenValue(47));
    }];
    
    
    
    
}


- (void)loginAction:(UIButton *)sender
{
    if (self.phoneTF.text.length<6) {
        return;
    }
    if (self.codeTF.text.length<6) {
        return;
    }if (self.NewPassTF.text.length<6) {
        return;
    }
    
        PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        NSMutableDictionary *dict =[NSMutableDictionary dictionary];
        dict[@"token"]  = userModel.token;
        
        NSString *str = [NSString stringWithFormat:@"%@?token=%@", ResetForgetPayPassword,dict[@"token"]];
        NSMutableDictionary *dic = [@{@"checkCode":self.codeTF.text,
                                     @"payPassword":self.NewPassTF.text
                                      } mutableCopy];
        
        [NetworkManage Post:str andParams:dic success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"code"]integerValue]==200) {
                [self showHint:@"操作成功"];

                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showHint:responseObject[@"message"]];
                
            }
            
            
            
        } failure:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];


}

- (void)codeAction:(UIButton *)sender
{

        PhoneZhuCeModel *userModel =[NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        NSMutableDictionary *dict =[NSMutableDictionary dictionary];
        dict[@"token"]  = userModel.token;
        
        NSString *str = [NSString stringWithFormat:@"%@?token=%@", GetCheckCode,dict[@"token"]];
    
        [NetworkManage Get:str andParams:nil success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            
            
        } failure:^(NSError *error) {
            [self showHint:@"网络错误"];
        }];
  
    //计时器
    self.secondsCountDown = 60;
    // self.senderButton.backgroundColor = [UIColor lightGrayColor];
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimeWithSeconds:) userInfo:nil repeats:YES];
    [self.countDownTimer fire];
}

- (void)countDownTimeWithSeconds:(NSTimer*)timerInfo
{
    if (self.secondsCountDown == 0)
    {
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
    
}


- (UITextField *)phoneTF
{
    if (!_phoneTF)
    {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.textColor = [UIColor similarBlackColor];
        _phoneTF.font = [UIFont systemFontOfSize:14];
        _phoneTF.placeholder = @"请输入密码";
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
        _NewPassTF.placeholder = @"请再次输入密码";
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
        _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"确定" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor mainBlueColorEnable];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
        [_loginBtn setUserInteractionEnabled:YES];
    }
    
    return _loginBtn;
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
