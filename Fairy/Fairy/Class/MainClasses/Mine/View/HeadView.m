//
//  HeadView.m
//  Fairy
//
//  Created by iOS-Mac on 2018/8/7.
//  Copyright © 2018年 . All rights reserved.
//

#import "HeadView.h"

@interface HeadView()
@property(nonatomic,strong) UIImageView *headIM;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UIButton *loginBtn;
@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        [self creatSubViews];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginTapClick)];
        [self addGestureRecognizer:tap];
    
    }
    return self;
}

-(void)creatSubViews{

    
    UIImageView *backIM =[UIImageView new];
    backIM.userInteractionEnabled = YES;
    backIM.image =[UIImage imageNamed:@"person_background"];
    [self addSubview:backIM];
    [backIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIImageView *headIM =[UIImageView new];
    self.headIM.userInteractionEnabled = YES;
    self.headIM = headIM;
    [headIM sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"personal_img"]];
    [self addSubview:headIM];
    [headIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(LL_StatusBarHeight+34);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    
    UILabel *nameLab=[UILabel new];
    [self addSubview:nameLab];
    self.nameLab = nameLab;
    self.nameLab.font = AdaptedFontSize(27);
    self.nameLab.textAlignment =NSTextAlignmentCenter;
    nameLab.hidden= YES;
    nameLab.text=@"昵称";
    nameLab.textColor =[UIColor whiteColor];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headIM.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(15);
    }];
    
    
    
    UIButton *loginBtn =[[UIButton alloc]init];
    [self addSubview:loginBtn];
    self.loginBtn = loginBtn;
    [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = AdaptedFontSize(30);
    [loginBtn addTarget:self action:@selector(loginTapClick) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.cornerRadius = 3;
    loginBtn.layer.masksToBounds = YES;
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headIM.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(32);
    }];
    
}

-(void)loginTapClick{
    if (_delegate && [_delegate respondsToSelector:@selector(headViewLoginTapClick)]) {
        [_delegate headViewLoginTapClick];
    }
}

-(void)updateUserInfo:(NSDictionary *)dict{
    
    if (!dict) {
        self.nameLab.text = @"昵称";
        self.headIM.image = [UIImage imageNamed:@"personal_img"];
        self.nameLab.hidden=NO;
        self.loginBtn.hidden = YES;
        return;
    }
    
    

    if ([Tool isBlankString:dict[@"nickname"]]) {
        self.nameLab.text = @"昵称";
    }
    else{
        self.nameLab.text = dict[@"nickname"];
    }
    

    if (![Tool isBlankString:dict[@"headerPic"]]) {
        [self.headIM sd_setImageWithURL:[NSURL URLWithString:dict[@"headerPic"]] placeholderImage:[UIImage imageNamed:@"personal_img"]];
    }else{
        self.headIM.image = [UIImage imageNamed:@"personal_img"];
    }
    self.nameLab.hidden=NO;
    self.loginBtn.hidden = YES;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
