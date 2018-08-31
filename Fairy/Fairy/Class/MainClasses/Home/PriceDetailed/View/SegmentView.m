//
//  SegmentView.m
//  Fairy
//
//  Created by iOS-Mac on 2018/8/31.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "SegmentView.h"

@interface SegmentView()

@property(nonatomic,strong)UIButton *RMBbtn;
@property(nonatomic,strong)UIButton *USAbtn;

@property(nonatomic,strong)UIButton *marchBtn;
@property(nonatomic,strong)UIButton *juneBtn;
@property(nonatomic,strong)UIButton *yearBtn;
@end

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
    
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
  
    UIView *priceView=[[UIView alloc]initWithFrame:CGRectMake(20, 0, 60, 22)];
    priceView.layer.cornerRadius = 11;
    priceView.layer.masksToBounds = YES;
    priceView.layer.borderColor = [UIColor grayColor].CGColor;
    priceView.layer.borderWidth =1;
    [self addSubview:priceView];
    
    UIButton *RMBbtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    self.RMBbtn = RMBbtn;
    [priceView addSubview:RMBbtn];
    [RMBbtn setImage:[UIImage imageNamed:@"icon_switch_money_$"] forState:UIControlStateNormal];
    [RMBbtn setImage:[UIImage imageNamed:@"icon_switch_money_$_select"] forState:UIControlStateSelected];
    RMBbtn.selected = YES;
    [RMBbtn addTarget:self action:@selector(rmbBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *USAbtn =[[UIButton alloc]initWithFrame:CGRectMake(30, 0, 30, 22)];
    self.USAbtn = USAbtn;
    [priceView addSubview:USAbtn];
    [USAbtn setImage:[UIImage imageNamed:@"icon_switch_money_￥"] forState:UIControlStateNormal];
    [USAbtn setImage:[UIImage imageNamed:@"icon_switch_money_￥_select"] forState:UIControlStateSelected];
    USAbtn.selected = NO;
    [USAbtn addTarget:self action:@selector(usaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    ///时间///
    UIView *timeView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20-120, 0, 120, 22)];
    timeView.layer.cornerRadius = 11;
    timeView.layer.masksToBounds = YES;
    timeView.layer.borderColor = [UIColor grayColor].CGColor;
    timeView.layer.borderWidth =1;
    [self addSubview:timeView];
    
    
    UIButton *marchBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 22)];
    self.marchBtn = marchBtn;
    [timeView addSubview:marchBtn];
    [marchBtn setImage:[UIImage imageNamed:@"icon_switch_time_march"] forState:UIControlStateNormal];
    [marchBtn setImage:[UIImage imageNamed:@"icon_switch_time_march_select"] forState:UIControlStateSelected];
    marchBtn.selected = YES;
    [marchBtn addTarget:self action:@selector(marchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *juneBtn =[[UIButton alloc]initWithFrame:CGRectMake(40, 0, 40, 22)];
    self.juneBtn = juneBtn;
    [timeView addSubview:juneBtn];
    [juneBtn setImage:[UIImage imageNamed:@"icon_switch_time_june"] forState:UIControlStateNormal];
    [juneBtn setImage:[UIImage imageNamed:@"icon_switch_time_june_select"] forState:UIControlStateSelected];
    juneBtn.selected = NO;
    [juneBtn addTarget:self action:@selector(juneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *yearBtn =[[UIButton alloc]initWithFrame:CGRectMake(80, 0, 40, 22)];
    self.yearBtn = yearBtn;
    [timeView addSubview:yearBtn];
    [yearBtn setImage:[UIImage imageNamed:@"icon_switch_time_year"] forState:UIControlStateNormal];
    [yearBtn setImage:[UIImage imageNamed:@"icon_switch_time_year_select"] forState:UIControlStateSelected];
    yearBtn.selected = NO;
    [yearBtn addTarget:self action:@selector(yearBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}



-(void)rmbBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.USAbtn.selected = NO;
}
-(void)usaBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.RMBbtn.selected = NO;
}



-(void)marchBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.juneBtn.selected = NO;
    self.yearBtn.selected = NO;
}

-(void)juneBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.marchBtn.selected = NO;
    self.yearBtn.selected = NO;
}

-(void)yearBtnClick:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    btn.selected = YES;
    self.marchBtn.selected = NO;
    self.juneBtn.selected = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
