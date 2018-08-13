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
    //
    UILabel *indexLab =[UILabel new];
    indexLab.text=@"开盘价：117.3800";
    indexLab.font=AdaptedFontSize(24);
    indexLab.textColor =[UIColor colorWithHex:@"#323232"];
    indexLab.textAlignment = NSTextAlignmentLeft;
    self.indexLab = indexLab;
    [self addSubview:indexLab];
    [indexLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AdaptedHeight(20));
        make.left.mas_equalTo(AdaptedWidth(54));
        make.width.mas_equalTo(AdaptedWidth(300));
        make.height.mas_equalTo(AdaptedHeight(30));
    }];
    
    
    //
    UILabel *increaseLab=[UILabel new];
    self.increaseLab = increaseLab;
//    increaseLab.text=@"收盘价：373.12";
    increaseLab.font=AdaptedFontSize(24);
    increaseLab.textColor = [UIColor colorWithHex:@"#323232"];
    increaseLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:increaseLab];
    [increaseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-AdaptedHeight(20));
        make.left.mas_equalTo(AdaptedWidth(54));
        make.width.mas_equalTo(AdaptedWidth(300));
        make.height.mas_equalTo(AdaptedHeight(30));
    }];
    
    
    //
    UILabel *currentPriceLab =[UILabel new];
    self.currentPriceLab = currentPriceLab;
//    currentPriceLab.text=@"最高价：116.7353";
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
    
    
    //
    UILabel *priceRiseLab=[UILabel new];
//    priceRiseLab.text=@"最低价：373.12";
    self.priceRiseLab = priceRiseLab;
    priceRiseLab.font=AdaptedFontSize(24);
    priceRiseLab.textColor = [UIColor colorWithHex:@"#323232"];
    priceRiseLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:priceRiseLab];
    [priceRiseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-AdaptedHeight(25));
        make.right.mas_equalTo(-AdaptedWidth(54));
        make.width.mas_equalTo(AdaptedWidth(250));
        make.height.mas_equalTo(AdaptedHeight(22));
    }];

    
}


-(void)setKLineModel:(Y_KLineModel *)kLineModel
{
    _kLineModel = kLineModel;
    self.indexLab.text= [NSString stringWithFormat:@"开盘价：%@",kLineModel.Open];
    self.increaseLab.text= [NSString stringWithFormat:@"收盘价：%@",kLineModel.Close];
    self.currentPriceLab.text =[NSString stringWithFormat:@"最高价：%@",kLineModel.High];
    self.priceRiseLab.text=[NSString stringWithFormat:@"最低价：%@",kLineModel.Low];
    
}
@end
