//
//  InTimePriceView.m
//  Fairy
//
//  Created by  on 2018/8/3.
//  Copyright © 2018年 . All rights reserved.
//

#import "InTimePriceView.h"

@interface InTimePriceView()
@property(nonatomic,strong)UILabel *indexLab;
@property(nonatomic,strong)UILabel *increaseLab;
@property(nonatomic,strong)UILabel *currentPriceLab;
@property(nonatomic,strong)UILabel *priceRiseLab;

@end

@implementation InTimePriceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
        self.backgroundColor =[UIColor colorWithHex:@"#ffffff"];
    }
    return self;
}

-(void)creatSubViews{
    
    UILabel *indexLab =[UILabel new];
    indexLab.text=@"￥117.3800";
    indexLab.font=AdaptedFontSize(36);
    indexLab.textColor =[UIColor colorWithHex:@"#2eaf04"];
    indexLab.textAlignment = NSTextAlignmentLeft;
    indexLab.textColor =[UIColor greenColor];
    self.indexLab = indexLab;
    [self addSubview:indexLab];
    
    [indexLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AdaptedHeight(20));
        make.left.mas_equalTo(AdaptedWidth(54));
        make.width.mas_equalTo(AdaptedWidth(300));
        make.height.mas_equalTo(AdaptedHeight(30));
    }];
    
    
    
    UILabel *increaseLab=[UILabel new];
    self.increaseLab = increaseLab;
    increaseLab.text=@"+0.7600  +0.66%";
    increaseLab.font=AdaptedFontSize(24);
    increaseLab.textColor = [UIColor colorWithHex:@"#2eaf04"];
    increaseLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:increaseLab];
    
    [increaseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-AdaptedHeight(20));
        make.left.mas_equalTo(AdaptedWidth(54));
        make.width.mas_equalTo(AdaptedWidth(300));
        make.height.mas_equalTo(AdaptedHeight(30));
    }];
    
    
    UILabel *currentPriceLab =[UILabel new];
    currentPriceLab.text=@"当前价格:116.7353";
    currentPriceLab.textColor = [UIColor colorWithHex:@"#323232"];
    currentPriceLab.font=AdaptedFontSize(24);
    currentPriceLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:currentPriceLab];
    
    [currentPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AdaptedHeight(20));
        make.right.mas_equalTo(-AdaptedWidth(54));
        make.width.mas_equalTo(AdaptedWidth(250));
        make.height.mas_equalTo(AdaptedHeight(22));
    }];
    
    UILabel *priceRiseLab=[UILabel new];
    //    priceRiseLab.text=@"涨       幅:+16%";
    self.priceRiseLab = priceRiseLab;
    priceRiseLab.font=AdaptedFontSize(24);
    priceRiseLab.textColor = [UIColor colorWithHex:@"#323232"];
    priceRiseLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:priceRiseLab];
    
    //设置颜色
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc] initWithString:@"涨       幅:"];
    [attributedString addAttribute:NSFontAttributeName value:AdaptedFontSize(24) range:NSMakeRange(0, attributedString.length)];//设置字体属性 大小
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"#323232"] range:NSMakeRange(0, attributedString.length)];//设置字体颜色
    
    NSMutableAttributedString *attributedString2=[[NSMutableAttributedString alloc] initWithString:@"+16%"];
    [attributedString2 addAttribute:NSFontAttributeName value:AdaptedFontSize(24) range:NSMakeRange(0, attributedString2.length)];//设置字体属性 大小
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"#2eaf04"] range:NSMakeRange(0, attributedString2.length)];//设置字体颜色
    [attributedString appendAttributedString:attributedString2];//拼接字符串
    priceRiseLab.attributedText= attributedString;
    
    
    [priceRiseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-AdaptedHeight(25));
        make.right.mas_equalTo(-AdaptedWidth(54));
        make.width.mas_equalTo(AdaptedWidth(250));
        make.height.mas_equalTo(AdaptedHeight(22));
    }];

    
}

@end
