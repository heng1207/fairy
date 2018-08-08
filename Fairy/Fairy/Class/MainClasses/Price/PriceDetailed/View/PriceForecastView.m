//
//  PriceForecastView.m
//  Fairy
//
//  Created by iOS-Mac on 2018/8/8.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceForecastView.h"

@interface PriceForecastView()

@property(nonatomic,strong)UILabel *changeLab;
@property(nonatomic,strong)UILabel *priceLab;

@end

@implementation PriceForecastView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =[UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    
    UILabel *introduceLab = [[UILabel alloc] init];
    introduceLab.frame = CGRectMake(12, 12, SCREEN_WIDTH-24, 20);
    introduceLab.text=@"对一日内价格进行预测：";
    introduceLab.textColor = [UIColor blackColor];
    introduceLab.font = [UIFont systemFontOfSize:15];
    introduceLab = introduceLab;
    introduceLab.numberOfLines = 0;
    [self addSubview:introduceLab];
    
    
    UILabel *changeLab = [[UILabel alloc] init];
    changeLab.frame = CGRectMake(12, CGRectGetMaxY(introduceLab.frame)+5, SCREEN_WIDTH-24, 20);
    changeLab.textColor = [UIColor blackColor];
    changeLab.font = [UIFont systemFontOfSize:15];
    changeLab.numberOfLines = 0;
    _changeLab = changeLab;
    [self addSubview:changeLab];
    
    
    UILabel *priceLab = [[UILabel alloc] init];
    priceLab.frame = CGRectMake(12, CGRectGetMaxY(changeLab.frame)+5, SCREEN_WIDTH-24, 20);
    priceLab.textColor = [UIColor blackColor];
    priceLab.font = [UIFont systemFontOfSize:15];
    priceLab.numberOfLines = 0;
    _priceLab = priceLab;
    [self addSubview:priceLab];
}

-(void)setDataDic:(NSMutableDictionary *)dataDic{
    _dataDic = dataDic;
    BOOL isChangeInt = [Tool isPureInt:dataDic[@"pct_change"]];
    if (isChangeInt) {
        _changeLab.text = [NSString stringWithFormat:@"涨幅：%@.0",dataDic[@"pct_change"]];
    }
    else{
        float change = [dataDic[@"pct_change"] floatValue];
        _changeLab.text = [NSString stringWithFormat:@"涨幅：%0.3f",change];
    }
    
    
    BOOL isPriceInt = [Tool isPureInt:dataDic[@"price"]];
    if (isPriceInt) {
        _priceLab.text = [NSString stringWithFormat:@"今日收盘价格：%@.0",dataDic[@"price"]];
    }
    else{
        float price = [dataDic[@"price"] floatValue];
        _priceLab.text = [NSString stringWithFormat:@"今日收盘价格：%0.3f",price];
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
