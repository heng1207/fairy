//
//  HeadView.m
//  Fairy
//
//  Created by iOS-Mac on 2018/8/7.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "HeadView.h"

@interface HeadView()
@property(nonatomic,strong) UIImageView *headIM;
@property(nonatomic,strong) UILabel *nameLab;
@property(nonatomic,strong) UILabel *explainLab;
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
    [headIM sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"photo"]];
    [self addSubview:headIM];
    [headIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(AdaptedWidth(90));
        make.width.mas_equalTo(AdaptedWidth(100));
        make.height.mas_equalTo(AdaptedWidth(100));
    }];
    
    
    UILabel *nameLab=[UILabel new];
    [self addSubview:nameLab];
    self.nameLab = nameLab;
    self.nameLab.font = AdaptedFontSize(27);
    self.nameLab.userInteractionEnabled = YES;
    nameLab.text=@"昵称昵称昵称";
    nameLab.textColor =[UIColor whiteColor];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headIM);
        make.left.mas_equalTo(headIM.mas_right).offset(AdaptedWidth(30));
        make.width.mas_equalTo(AdaptedWidth(400));
        make.height.mas_equalTo(AdaptedWidth(48));
    }];
    
    
    UILabel *explainLab=[UILabel new];
    [self addSubview:explainLab];
    self.explainLab = explainLab;
    explainLab.font = AdaptedFontSize(27);
    explainLab.textColor =[UIColor whiteColor];
    explainLab.userInteractionEnabled = YES;
    explainLab.text=@"登录后可享受更多服务";
    [explainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headIM.mas_bottom).offset(AdaptedWidth(30));
        make.left.mas_equalTo(AdaptedWidth(90));
        make.width.mas_equalTo(AdaptedWidth(500));
        make.height.mas_equalTo(AdaptedWidth(48));
    }];
    
}

-(void)loginTapClick{
    if (_delegate && [_delegate respondsToSelector:@selector(headViewLoginTapClick)]) {
        [_delegate headViewLoginTapClick];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
