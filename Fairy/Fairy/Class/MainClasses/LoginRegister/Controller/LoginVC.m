//
//  LoginVC.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "FindPwVC.h"

@interface LoginVC ()
@property(nonatomic,strong)UITextField *phoneTF;
@property(nonatomic,strong)UITextField *passwordTF;
@end

@implementation LoginVC

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
    self.phoneTF= phoneTF;
    phoneTF.placeholder=@"请输入手机号";
    [self.view addSubview:phoneTF];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoIM.mas_bottom).offset(AdaptedHeight(90));
        make.left.mas_equalTo(phoneLab.mas_right).offset(AdaptedWidth(20));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];

    UIView *line1 =[UIView new];
    line1.backgroundColor=[UIColor blueColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLab.mas_bottom).offset(AdaptedHeight(10));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.right.mas_equalTo(-AdaptedWidth(50));
        make.height.mas_equalTo(AdaptedWidth(1));
    }];
    
    
    //密码
    UILabel *passwordLab =[UILabel new];
    self.passwordTF = passwordLab;
    passwordLab.text=@"密码";
    passwordLab.font=[UIFont systemFontOfSize:15];
    passwordLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:passwordLab];
    
    [passwordLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.width.mas_equalTo(AdaptedWidth(116));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UITextField *passwordTF =[UITextField new];
    passwordTF.placeholder=@"请输入密码";
    [self.view addSubview:passwordTF];
    [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(passwordLab.mas_right).offset(AdaptedWidth(20));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UIButton *findPWBtn =[UIButton new];
    [findPWBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    findPWBtn.layer.cornerRadius = AdaptedHeight(25);
    findPWBtn.layer.masksToBounds = YES;
    findPWBtn.backgroundColor =[UIColor blueColor];
    [self.view addSubview:findPWBtn];
    [findPWBtn addTarget:self action:@selector(findPWClick) forControlEvents:UIControlEventTouchUpInside];
    [findPWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptedHeight(18));
        make.right.mas_equalTo(-AdaptedWidth(38));
        make.width.mas_equalTo(AdaptedWidth(200));
        make.height.mas_equalTo(AdaptedHeight(50));
    }];
    
    UIView *line2 =[UIView new];
    line2.backgroundColor=[UIColor blueColor];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordLab.mas_bottom).offset(AdaptedHeight(10));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.right.mas_equalTo(-AdaptedWidth(50));
        make.height.mas_equalTo(AdaptedWidth(1));
    }];
    
    
    

    //登录注册
    UIButton *LoginBtn =[UIButton new];
    LoginBtn.backgroundColor =[UIColor blueColor];
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    LoginBtn.layer.cornerRadius = AdaptedHeight(25);
    LoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:LoginBtn];
    [LoginBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(AdaptedHeight(50));
        make.left.mas_equalTo(AdaptedWidth(64));
        make.right.mas_equalTo(-AdaptedWidth(64));
        make.height.mas_equalTo(AdaptedHeight(76));
    }];

    UIButton *registerBtn =[UIButton new];
//    registerBtn.backgroundColor =[UIColor blueColor];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
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
    
    
    
    //三方登录
    float leftRightSpace = AdaptedWidth(60);
    float MidSpace = AdaptedWidth(84);
    float Y = LL_TabbarSafeBottomMargin + AdaptedHeight(196);
    float width =  (UIScreenW - 2*leftRightSpace- 2*MidSpace)/3;
    float height = AdaptedHeight(118);
    for (NSInteger i =0; i<3; i++) {
        UIButton *btn =[[UIButton alloc]init];
        btn.frame= CGRectMake(leftRightSpace + i*(MidSpace+width), UIScreenH-Y, width, height);
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor =[UIColor blueColor];
        [self.view addSubview:btn];
    }
    
    
    UILabel *thirdPartyLab= [UILabel new];
    thirdPartyLab.text = @"第三方登录";
    thirdPartyLab.font = AdaptedFontSize(20);
    thirdPartyLab.textColor = [UIColor grayColor];
    thirdPartyLab.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:thirdPartyLab];
    
    float thirdPartyY = LL_TabbarSafeBottomMargin + AdaptedHeight(250);
    [thirdPartyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(- thirdPartyY);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(AdaptedHeight(162));
        make.height.mas_equalTo(AdaptedHeight(42));
    }];
    
    UIView *thirdPartyline1 = [UIView new];
    thirdPartyline1.backgroundColor =[UIColor grayColor];
    [self.view addSubview:thirdPartyline1];
    [thirdPartyline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(AdaptedWidth(60));
        make.centerY.mas_equalTo(thirdPartyLab);
        make.right.mas_equalTo(thirdPartyLab.mas_left).offset(-AdaptedWidth(24));
        make.height.mas_equalTo(AdaptedHeight(1));
    }];
    
    UIView *thirdPartyline2 = [UIView new];
    thirdPartyline2.backgroundColor =[UIColor grayColor];
    [self.view addSubview:thirdPartyline2];
    [thirdPartyline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(thirdPartyLab.mas_right).offset(AdaptedWidth(24));
        make.centerY.mas_equalTo(thirdPartyLab);
        make.right.mas_equalTo(-AdaptedWidth(60));
        make.height.mas_equalTo(AdaptedHeight(1));
    }];
    
}


-(void)registerClick{
    RegisterVC *vc=[RegisterVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)findPWClick{
    FindPwVC *vc=[FindPwVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
