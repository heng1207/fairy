//
//  RegisterVC.m
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property(nonatomic,strong)UITextField *userNameTF;
@property(nonatomic,strong)UITextField *passwordTF;
@property(nonatomic,strong)UITextField *phoneTF;
@property(nonatomic,strong)UITextField *codeTF;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    [self creatSubViews];
    
    // Do any additional setup after loading the view.
}

-(void)creatSubViews{
    
    UIImageView *logoIM=[UIImageView new];
    logoIM.image =[UIImage imageNamed:@"loginLogo"];
    [self.view addSubview:logoIM];
    [logoIM mas_makeConstraints:^(MASConstraintMaker *make) {
        if (LL_iPhoneX) {
            make.top.mas_equalTo(AdaptedHeight(110+44));
        }
        else{
            make.top.mas_equalTo(AdaptedHeight(110));
        }
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(AdaptedWidth(436));
        make.height.mas_equalTo(AdaptedHeight(230));
    }];
    
    //用户名
    UILabel *userNameLab =[UILabel new];
    userNameLab.text=@"用户名";
    userNameLab.font = AdaptedFontSize(34);
    userNameLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userNameLab];
    
    [userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoIM.mas_bottom).offset(AdaptedHeight(66));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.width.mas_equalTo(AdaptedWidth(116));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UITextField *userNameTF =[UITextField new];
    self.userNameTF = userNameTF;
    userNameTF.font= AdaptedFontSize(34);
    userNameTF.placeholder=@"请设置用户名";
    [self.view addSubview:userNameTF];
    [userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoIM.mas_bottom).offset(AdaptedHeight(66));
        make.left.mas_equalTo(userNameLab.mas_right).offset(AdaptedWidth(12));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    UIView *line1 =[UIView new];
    line1.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userNameLab.mas_bottom).offset(AdaptedHeight(10));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.right.mas_equalTo(-AdaptedWidth(50));
        make.height.mas_equalTo(AdaptedWidth(1));
    }];
    
    
    
    //密码
    UILabel *passwordLab =[UILabel new];
//    passwordLab.text=@"密   码";
    passwordLab.text=@"密    码";
    passwordLab.font = AdaptedFontSize(34);
    passwordLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passwordLab];
    
    [passwordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.width.mas_equalTo(AdaptedWidth(116));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UITextField *passwordTF =[UITextField new];
    self.passwordTF = passwordTF;
    passwordTF.font= AdaptedFontSize(34);
    passwordTF.placeholder=@"请输入密码";
    [self.view addSubview:passwordTF];
    [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(passwordLab.mas_right).offset(AdaptedWidth(12));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UIView *line2 =[UIView new];
    line2.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordLab.mas_bottom).offset(AdaptedHeight(10));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.right.mas_equalTo(-AdaptedWidth(50));
        make.height.mas_equalTo(AdaptedWidth(1));
    }];
    

    
    
    //手机号
    UILabel *phoneLab =[UILabel new];
    phoneLab.text=@"手机号";
    phoneLab.font= AdaptedFontSize(34);
    phoneLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneLab];
    
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.width.mas_equalTo(AdaptedWidth(116));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UITextField *phoneTF =[UITextField new];
    self.phoneTF = phoneTF;
    phoneTF.font= AdaptedFontSize(34);
    phoneTF.placeholder=@"请输入手机号";
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneTF];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(phoneLab.mas_right).offset(AdaptedWidth(12));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    UIButton *sendCodeBtn =[UIButton new];
    [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendCodeBtn.backgroundColor = [UIColor colorWithHex:@"#031b92"];
    sendCodeBtn.titleLabel.font = AdaptedFontSize(28);
    sendCodeBtn.titleLabel.textColor = [UIColor colorWithHex:@"#ffffff"];
    sendCodeBtn.layer.cornerRadius = AdaptedHeight(25);
    sendCodeBtn.layer.masksToBounds = YES;
    [self.view addSubview:sendCodeBtn];
    [sendCodeBtn addTarget:self action:@selector(sendCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(AdaptedHeight(28));
        make.right.mas_equalTo(-AdaptedWidth(38));
        make.width.mas_equalTo(AdaptedWidth(216));
        make.height.mas_equalTo(AdaptedHeight(50));
    }];
    
    
    UIView *line3 =[UIView new];
    line3.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLab.mas_bottom).offset(AdaptedHeight(10));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.right.mas_equalTo(-AdaptedWidth(50));
        make.height.mas_equalTo(AdaptedWidth(1));
    }];
    
    
    
    //验证码
    UILabel *codeLab =[UILabel new];
    codeLab.text=@"验证码";
    codeLab.font= AdaptedFontSize(34);
    codeLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:codeLab];
    
    [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.width.mas_equalTo(AdaptedWidth(116));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UITextField *codeTF =[UITextField new];
    self.codeTF = codeTF;
    codeTF.placeholder=@"请输入验证码";
    codeTF.font= AdaptedFontSize(34);
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:codeTF];
    [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(codeLab.mas_right).offset(AdaptedWidth(12));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UIView *line4 =[UIView new];
    line4.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self.view addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeLab.mas_bottom).offset(AdaptedHeight(10));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.right.mas_equalTo(-AdaptedWidth(50));
        make.height.mas_equalTo(AdaptedWidth(1));
    }];
    
    
    
    
    //登录注册
    UIButton *LoginBtn =[UIButton new];
    LoginBtn.backgroundColor =[UIColor blueColor];
    [LoginBtn setTitle:@"注册" forState:UIControlStateNormal];
    LoginBtn.titleLabel.font = AdaptedFontSize(28);
    LoginBtn.layer.cornerRadius = AdaptedHeight(25);
    LoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:LoginBtn];
    [LoginBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line4.mas_bottom).offset(AdaptedHeight(60));
        make.left.mas_equalTo(AdaptedWidth(64));
        make.right.mas_equalTo(-AdaptedWidth(64));
        make.height.mas_equalTo(AdaptedHeight(76));
    }];
    
    UIButton *registerBtn =[UIButton new];
    //    registerBtn.backgroundColor =[UIColor blueColor];
    [registerBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = AdaptedFontSize(28);
    [registerBtn setTitleColor:[UIColor colorWithHex:@"#000b81"] forState:UIControlStateNormal];
    //    registerBtn.layer.cornerRadius = AdaptedHeight(25);
    //    registerBtn.layer.masksToBounds = YES;
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LoginBtn.mas_bottom).offset(AdaptedHeight(20));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(AdaptedHeight(180));
        make.height.mas_equalTo(AdaptedHeight(40));
    }];
    
    
}

-(void)registerClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sendCodeClick{
    
    if (![Tool checkTel:self.phoneTF.text]){
        return;
    }
    NSLog(@"%@",GetLoginMessage(self.phoneTF.text));
    [NetworkManage  Get:GetLoginMessage(self.phoneTF.text)  andParams:nil success:^(id responseObject) {
        NSMutableDictionary *dic = (NSMutableDictionary*)responseObject;
        NSLog(@"%@",responseObject);
        [self showHint:dic[@"message"]];
        
    } failure:^(NSError *error) {
        [self showHint:@"网络有问题"];
        NSLog(@"%@",error);
    }];
}
-(void)LoginClick{
    if ([Tool isBlankString:self.userNameTF.text]) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"用户名不能为空" message:@"请键入用户名" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if ( ![Tool checkPassWord:self.passwordTF.text]){
        return;
    }
    if ( ![Tool checkTel:self.phoneTF.text]){
        return;
    }
    if ([Tool isBlankString:self.codeTF.text]) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"验证码不能为空" message:@"请键入验证码" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"loginName"] = self.userNameTF.text;
    dict[@"password"] = self.passwordTF.text;
    dict[@"phoneNumber"] = self.phoneTF.text;
    dict[@"checkCode"] = self.codeTF.text;
    [NetworkManage Post:Register andParams:dict success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableDictionary *dic = (NSMutableDictionary*)responseObject;
        if ([dic[@"code"] integerValue] ==200 ) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self showHint:dic[@"message"]];
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
