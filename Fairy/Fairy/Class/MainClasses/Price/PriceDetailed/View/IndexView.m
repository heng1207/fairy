//
//  IndexView.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "IndexView.h"

@interface IndexView ()

@property(nonatomic,strong)UILabel *indexLab;
@property(nonatomic,strong)UILabel *increaseLab;
@property(nonatomic,strong)UILabel *currentPriceLab;
@property(nonatomic,strong)UILabel *priceRiseLab;

@end

@implementation IndexView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    UILabel *indexLab =[UILabel new];
    indexLab.text=@"￥117.3800";
    indexLab.font=[UIFont systemFontOfSize:18];
    indexLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:indexLab];
    
    [indexLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AdaptedHeight(20));
        make.left.mas_equalTo(AdaptedWidth(60));
        make.width.mas_equalTo(AdaptedWidth(300));
        make.height.mas_equalTo(AdaptedHeight(22));
    }];
    
    
    
    UILabel *increaseLab=[UILabel new];
    increaseLab.text=@"+0.7600  +0.66%";
    increaseLab.font=[UIFont systemFontOfSize:16];
    increaseLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:increaseLab];
    
    [increaseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-AdaptedHeight(20));
        make.left.mas_equalTo(AdaptedWidth(60));
        make.width.mas_equalTo(AdaptedWidth(300));
        make.height.mas_equalTo(AdaptedHeight(22));
    }];
    
    
    UILabel *currentPriceLab =[UILabel new];
    currentPriceLab.text=@"当前价格:116.7353";
    currentPriceLab.font=[UIFont systemFontOfSize:16];
    currentPriceLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:currentPriceLab];
    
    [currentPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AdaptedHeight(20));
        make.right.mas_equalTo(-AdaptedWidth(60));
        make.width.mas_equalTo(AdaptedWidth(300));
        make.height.mas_equalTo(AdaptedHeight(22));
    }];
    
    UILabel *priceRiseLab=[UILabel new];
    priceRiseLab.text=@"+16%";
    priceRiseLab.font=[UIFont systemFontOfSize:16];
    priceRiseLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:priceRiseLab];
    
    [priceRiseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-AdaptedHeight(20));
        make.right.mas_equalTo(-AdaptedWidth(60));
        make.width.mas_equalTo(AdaptedWidth(300));
        make.height.mas_equalTo(AdaptedHeight(22));
    }];
    
    UIView *line1 =[UIView new];
    line1.backgroundColor=[UIColor grayColor];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(AdaptedWidth(1));
        make.bottom.mas_equalTo(0);
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
