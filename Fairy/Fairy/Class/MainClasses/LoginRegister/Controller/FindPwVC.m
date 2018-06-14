//
//  FindPwVC.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "FindPwVC.h"


@interface FindPwVC ()
@property(nonatomic,strong)UITextField *phoneTF;
@property(nonatomic,strong)UITextField *passwordTF;
@property(nonatomic,strong)UITextField *codeTF;

@end

@implementation FindPwVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    [self creatSubViews];
    
    // Do any additional setup after loading the view.
}

-(void)creatSubViews{
    
    UIImageView *logoIM=[UIImageView new];
    [self.view addSubview:logoIM];
    [logoIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AdaptedHeight(114));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(AdaptedWidth(356));
        make.height.mas_equalTo(AdaptedHeight(182));
    }];
    
    
    //手机号
    UILabel *phoneLab =[UILabel new];
    phoneLab.text=@"手机号";
    phoneLab.font=[UIFont systemFontOfSize:15];
    phoneLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneLab];
    
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoIM.mas_bottom).offset(AdaptedHeight(90));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.width.mas_equalTo(AdaptedWidth(116));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UITextField *phoneTF =[UITextField new];
    self.phoneTF = phoneTF;
    phoneTF.placeholder=@"请输入手机号";
    [self.view addSubview:phoneTF];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoIM.mas_bottom).offset(AdaptedHeight(90));
        make.left.mas_equalTo(phoneLab.mas_right).offset(AdaptedWidth(20));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    UIButton *sendCodeBtn =[UIButton new];
    [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendCodeBtn.layer.cornerRadius = AdaptedHeight(25);
    sendCodeBtn.layer.masksToBounds = YES;
    sendCodeBtn.backgroundColor =[UIColor blueColor];
    [self.view addSubview:sendCodeBtn];
    [sendCodeBtn addTarget:self action:@selector(sendCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoIM.mas_bottom).offset(AdaptedHeight(100));
        make.right.mas_equalTo(-AdaptedWidth(38));
        make.width.mas_equalTo(AdaptedWidth(216));
        make.height.mas_equalTo(AdaptedHeight(50));
    }];
    
    
    UIView *line1 =[UIView new];
    line1.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLab.mas_bottom).offset(AdaptedHeight(10));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.right.mas_equalTo(-AdaptedWidth(50));
        make.height.mas_equalTo(AdaptedWidth(1));
    }];
    
    
    //验证码
    UILabel *codeLab =[UILabel new];
    codeLab.text=@"验证码";
    codeLab.font=[UIFont systemFontOfSize:15];
    codeLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:codeLab];
    
    [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.width.mas_equalTo(AdaptedWidth(116));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UITextField *codeTF =[UITextField new];
    self.codeTF = codeTF;
    codeTF.placeholder=@"请输入验证码";
    [self.view addSubview:codeTF];
    [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(codeLab.mas_right).offset(AdaptedWidth(20));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UIView *line2 =[UIView new];
    line2.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeLab.mas_bottom).offset(AdaptedHeight(10));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.right.mas_equalTo(-AdaptedWidth(50));
        make.height.mas_equalTo(AdaptedWidth(1));
    }];
    
    
    //密码
    UILabel *passwordLab =[UILabel new];
    passwordLab.text=@"新密码";
    passwordLab.font=[UIFont systemFontOfSize:15];
    passwordLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passwordLab];
    
    [passwordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.width.mas_equalTo(AdaptedWidth(116));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UITextField *passwordTF =[UITextField new];
    self.passwordTF= passwordTF;
    passwordTF.placeholder=@"请输入新密码";
    [self.view addSubview:passwordTF];
    [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(passwordLab.mas_right).offset(AdaptedWidth(20));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UIView *line3 =[UIView new];
    line3.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordLab.mas_bottom).offset(AdaptedHeight(10));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.right.mas_equalTo(-AdaptedWidth(50));
        make.height.mas_equalTo(AdaptedWidth(1));
    }];
    
    
    
    
    //提交
    UIButton *LoginBtn =[UIButton new];
    LoginBtn.backgroundColor =[UIColor blueColor];
    [LoginBtn setTitle:@"提交" forState:UIControlStateNormal];
    LoginBtn.layer.cornerRadius = AdaptedHeight(25);
    LoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:LoginBtn];
    [LoginBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).offset(AdaptedHeight(50));
        make.left.mas_equalTo(AdaptedWidth(64));
        make.right.mas_equalTo(-AdaptedWidth(64));
        make.height.mas_equalTo(AdaptedHeight(76));
    }];
    
    UIButton *registerBtn =[UIButton new];
    //    registerBtn.backgroundColor =[UIColor blueColor];
    [registerBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
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

-(void)LoginClick{
    
}
-(void)registerClick{
    [self.navigationController popViewControllerAnimated:YES];
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
