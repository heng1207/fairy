//
//  LoginVC.m
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "LoginVC.h"
#import "CodeLoginVC.h"
#import "RegisterVC.h"
#import "FindPwVC.h"
#import "PhoneZhuCeModel.h"
#import <UMShare/UMShare.h>


@interface LoginVC ()

@property(nonatomic,strong)UITextField *phoneTF;
@property(nonatomic,strong)UITextField *passwordTF;

@property(nonatomic,strong)NSArray *logoArr;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.logoArr= @[@"WechatFriend",@"QQLogo",@"WeiBo"];
    [self creatSubViews];
   
    // Do any additional setup after loading the view.
}

-(void)creatSubViews{
    

    UIButton *backBtn =[UIButton new];
    [self.view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"loginBack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (LL_iPhoneX) {
            make.top.mas_equalTo(AdaptedHeight(50+44));
        }
        else{
            make.top.mas_equalTo(AdaptedHeight(50));
        }
        make.left.mas_equalTo(AdaptedWidth(60));
        make.width.mas_equalTo(AdaptedWidth(36));
        make.height.mas_equalTo(AdaptedHeight(46));
    }];
    
    
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
    
    
    //手机号
    UILabel *phoneLab =[UILabel new];
    phoneLab.text=@"手机号";
    phoneLab.font= AdaptedFontSize(34);
    phoneLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneLab];
    
    [phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoIM.mas_bottom).offset(AdaptedHeight(66));
        make.left.mas_equalTo(AdaptedWidth(50));
        make.width.mas_equalTo(AdaptedWidth(116));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UITextField *phoneTF =[UITextField new];
    self.phoneTF= phoneTF;
    phoneTF.font= AdaptedFontSize(34);
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.placeholder=@"请输入手机号";
    [self.view addSubview:phoneTF];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoIM.mas_bottom).offset(AdaptedHeight(66));
        make.left.mas_equalTo(phoneLab.mas_right).offset(AdaptedWidth(12));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
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
    passwordTF.placeholder=@"请输入密码";
    self.passwordTF = passwordTF;
    passwordTF.font= AdaptedFontSize(34);
    [self.view addSubview:passwordTF];
    [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptedHeight(18));
        make.left.mas_equalTo(passwordLab.mas_right).offset(AdaptedWidth(12));
        make.width.mas_equalTo(AdaptedWidth(460));
        make.height.mas_equalTo(AdaptedHeight(70));
    }];
    
    
    UIButton *findPWBtn =[UIButton new];
    [findPWBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    findPWBtn.backgroundColor = [UIColor colorWithHex:@"#6876be"];
    findPWBtn.titleLabel.font = AdaptedFontSize(28);
    findPWBtn.titleLabel.textColor = [UIColor colorWithHex:@"#ffffff"];
    findPWBtn.layer.cornerRadius = AdaptedHeight(25);
    findPWBtn.layer.masksToBounds = YES;
    findPWBtn.backgroundColor =[UIColor blueColor];
    [self.view addSubview:findPWBtn];
    [findPWBtn addTarget:self action:@selector(findPWClick) forControlEvents:UIControlEventTouchUpInside];
    [findPWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line1.mas_bottom).offset(AdaptedHeight(28));
        make.right.mas_equalTo(-AdaptedWidth(38));
        make.width.mas_equalTo(AdaptedWidth(184));
        make.height.mas_equalTo(AdaptedHeight(50));
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
    
    
    
    
    //登录
    UIButton *LoginBtn =[UIButton new];
    LoginBtn.backgroundColor =[UIColor colorWithHex:@"#031b92"];
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    LoginBtn.titleLabel.textColor = [UIColor colorWithHex:@"#ffffff"];
    LoginBtn.titleLabel.font = AdaptedFontSize(28);
    LoginBtn.layer.cornerRadius = AdaptedHeight(25);
    LoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:LoginBtn];
    [LoginBtn addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(AdaptedHeight(56));
        make.left.mas_equalTo(AdaptedWidth(64));
        make.right.mas_equalTo(-AdaptedWidth(64));
        make.height.mas_equalTo(AdaptedHeight(76));
    }];
    
    
    //注册
    UIButton *registerBtn =[UIButton new];
    //    registerBtn.backgroundColor =[UIColor blueColor];
    registerBtn.titleLabel.font = AdaptedFontSize(28);
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    
    [registerBtn setTitleColor:[UIColor colorWithHex:@"#000b81"] forState:UIControlStateNormal];
    //    registerBtn.layer.cornerRadius = AdaptedHeight(25);
    //    registerBtn.layer.masksToBounds = YES;
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    float centerX= self.view.centerX;
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LoginBtn.mas_bottom).offset(AdaptedHeight(30));
        make.left.mas_equalTo(centerX-AdaptedWidth(180 + 20));
        make.width.mas_equalTo(AdaptedWidth(180));
        make.height.mas_equalTo(AdaptedHeight(40));
    }];
    
    
    //验证码登陆or用户名登陆
    UIButton *selectLoginBtn =[UIButton new];
    selectLoginBtn.titleLabel.font = AdaptedFontSize(28);
    //    registerBtn.backgroundColor =[UIColor blueColor];
    [selectLoginBtn setTitle:@"验证码登陆" forState:UIControlStateNormal];
    selectLoginBtn.selected = NO;
    [selectLoginBtn setTitleColor:[UIColor colorWithHex:@"#000b81"] forState:UIControlStateNormal];
    //    registerBtn.layer.cornerRadius = AdaptedHeight(25);
    //    registerBtn.layer.masksToBounds = YES;
    [self.view addSubview:selectLoginBtn];
    [selectLoginBtn addTarget:self action:@selector(codeLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [selectLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LoginBtn.mas_bottom).offset(AdaptedHeight(30));
        make.left.mas_equalTo(centerX+AdaptedWidth(20));
        make.width.mas_equalTo(AdaptedWidth(200));
        make.height.mas_equalTo(AdaptedHeight(40));
    }];
    
    
//    
//    //三方登录
//    float leftRightSpace = AdaptedWidth(60);
//    float MidSpace = AdaptedWidth(84);
//    float Y = LL_TabbarSafeBottomMargin + AdaptedHeight(196);
//    float width =  (UIScreenW - 2*leftRightSpace- 2*MidSpace)/3;
//    float height = AdaptedHeight(118);
//    for (NSInteger i =0; i<3; i++) {
//        UIButton *btn =[[UIButton alloc]init];
//        btn.frame= CGRectMake(leftRightSpace + i*(MidSpace+width), UIScreenH-Y, width, height);
//        btn.tag = i;
//        [btn setImage:[UIImage imageNamed:self.logoArr[i]] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
//    }
//    
    
    
//    UILabel *thirdPartyLab= [UILabel new];
//    thirdPartyLab.text = @"第三方登录";
//    thirdPartyLab.font = AdaptedFontSize(28);
//    thirdPartyLab.textColor = [UIColor colorWithHex:@"#a3a3a3"];
//    thirdPartyLab.textAlignment =NSTextAlignmentCenter;
//    [self.view addSubview:thirdPartyLab];
//    
//    float thirdPartyY = LL_TabbarSafeBottomMargin + AdaptedHeight(250);
//    [thirdPartyLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(- thirdPartyY);
//        make.centerX.mas_equalTo(self.view);
//        make.width.mas_equalTo(AdaptedHeight(162));
//        make.height.mas_equalTo(AdaptedHeight(42));
//    }];
//    
//    UIView *thirdPartyline1 = [UIView new];
//    thirdPartyline1.backgroundColor =[UIColor colorWithHex:@"#cccccc"];;
//    [self.view addSubview:thirdPartyline1];
//    [thirdPartyline1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(AdaptedWidth(60));
//        make.centerY.mas_equalTo(thirdPartyLab);
//        make.right.mas_equalTo(thirdPartyLab.mas_left).offset(-AdaptedWidth(24));
//        make.height.mas_equalTo(AdaptedHeight(1));
//    }];
//    
//    UIView *thirdPartyline2 = [UIView new];
//    thirdPartyline2.backgroundColor =[UIColor colorWithHex:@"#cccccc"];
//    [self.view addSubview:thirdPartyline2];
//    [thirdPartyline2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(thirdPartyLab.mas_right).offset(AdaptedWidth(24));
//        make.centerY.mas_equalTo(thirdPartyLab);
//        make.right.mas_equalTo(-AdaptedWidth(60));
//        make.height.mas_equalTo(AdaptedHeight(1));
//    }];
    
}
-(void)backBtnClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)registerClick{
    RegisterVC *vc=[RegisterVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)findPWClick{
    FindPwVC *vc=[FindPwVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)codeLoginClick{
    CodeLoginVC *vc=[CodeLoginVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)LoginClick{
    if ([Tool isBlankString:self.phoneTF.text]) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号不能为空" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if ([Tool isBlankString:self.passwordTF.text]) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"phoneNumber"] = self.phoneTF.text;
    dict[@"password"] = self.passwordTF.text;
//    dict[@"loginName"] = @"zhangfeng";
//    dict[@"password"] = @"000000";
//    [0]    (null)    @"token" : @"zhangsan_368373cbd1474f26ac75b70962944f26"
//    [1]    (null)    @"consumerID" : (long)46    
    [NetworkManage Post:UserNameLogin andParams:dict success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            /*
             {
             "code": 200,
             "message": "登录成功",
             "data": {
             "consumerID": 1,
             "token": "zhangfeng_d3675c660af54c7b901c10fb15c3dc91"
             }
             }
             
             */
            
            //登陆成功
            PhoneZhuCeModel *userModel= [PhoneZhuCeModel mj_objectWithKeyValues:obj[@"data"]];
            // 归档存储模型数据
            [NSKeyedArchiver archiveRootObject:userModel toFile:kFilePath];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"已登录" forKey:@"loginStatus"];
            [defaults synchronize];
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else {
            [self showHint:obj[@"message"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark 三方登陆
-(void)shareBtnClick:(UIButton *)btn{
    
    NSInteger shareType;
    if (btn.tag==0) {
        shareType = 1;
    }
    else if (btn.tag==1){
        shareType = 4;
    }
    else {
        shareType = 0;
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:shareType currentViewController:nil completion:^(id result, NSError *error) {
        if (!error) {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
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
