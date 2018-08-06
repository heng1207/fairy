//
//  IndexView.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "IndexView.h"

@interface IndexView ()

@property(nonatomic,strong)UILabel *indexLab;
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
    indexLab.font=AdaptedFontSize(36);
    indexLab.textColor =[UIColor colorWithHex:@"#2eaf04"];
    indexLab.textAlignment = NSTextAlignmentLeft;
    indexLab.textColor =[UIColor greenColor];
    self.indexLab = indexLab;
    [self addSubview:indexLab];
    
    [indexLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(AdaptedHeight(20));
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(AdaptedWidth(54));
        make.width.mas_equalTo(AdaptedWidth(300));
        make.height.mas_equalTo(AdaptedHeight(30));
    }];
    
    
    
    
    UILabel *currentPriceLab =[UILabel new];
    self.currentPriceLab = currentPriceLab;
    currentPriceLab.text=@"交易量：116.7353";
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
//    priceRiseLab.text=@"涨   幅：+16%";
    self.priceRiseLab = priceRiseLab;
    priceRiseLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:priceRiseLab];

    
    [priceRiseLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-AdaptedHeight(25));
        make.right.mas_equalTo(-AdaptedWidth(54));
        make.width.mas_equalTo(AdaptedWidth(250));
        make.height.mas_equalTo(AdaptedHeight(22));
    }];
    
    UIView *line1 =[UIView new];
    line1.backgroundColor=[UIColor colorWithHex:@"#cccccc"];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(AdaptedWidth(1));
        make.bottom.mas_equalTo(0);
    }];
    
}

-(void)setPriceModel:(PriceModel *)priceModel{
    _priceModel = priceModel;
    
    self.indexLab.text = priceModel.lastPrice;
    self.currentPriceLab.text = [NSString stringWithFormat:@"交易量：%@",priceModel.tradingVolume];

    
    //设置颜色
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc] initWithString:@"涨    幅："];
    [attributedString addAttribute:NSFontAttributeName value:AdaptedFontSize(24) range:NSMakeRange(0, attributedString.length)];//设置字体属性 大小
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"#323232"] range:NSMakeRange(0, attributedString.length)];//设置字体颜色
    
    NSMutableAttributedString *attributedString2=[[NSMutableAttributedString alloc] initWithString:priceModel.priceChangeRatio];
    [attributedString2 addAttribute:NSFontAttributeName value:AdaptedFontSize(24) range:NSMakeRange(0, attributedString2.length)];//设置字体属性 大小
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"#2eaf04"] range:NSMakeRange(0, attributedString2.length)];//设置字体颜色
    [attributedString appendAttributedString:attributedString2];//拼接字符串
    self.priceRiseLab.attributedText= attributedString;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
