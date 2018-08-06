//
//  PriceCell.m
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceCell.h"

@interface PriceCell()

@property (weak, nonatomic) IBOutlet UILabel *fromLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *volumeLab;
@property (weak, nonatomic) IBOutlet UILabel *increaseLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@end

@implementation PriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.fromLab.textColor =[UIColor colorWithHex:@"#aeaeae"];
    self.fromLab.font = AdaptedFontSize(23);
    
    self.nameLab.textColor =[UIColor colorWithHex:@"#000000"];
    self.nameLab.font = AdaptedFontSize(28);
    
    self.volumeLab.textColor =[UIColor colorWithHex:@"#aeaeae"];
    self.volumeLab.font = AdaptedFontSize(23);
    
    
    self.increaseLab.backgroundColor =[UIColor colorWithHex:@"#1cb91c"];
    self.increaseLab.textColor =[UIColor colorWithHex:@"#ffffff"];
    self.increaseLab.font = AdaptedFontSize(24);
    self.increaseLab.textAlignment =NSTextAlignmentCenter;
    self.increaseLab.layer.cornerRadius = 5;
    self.increaseLab.layer.masksToBounds = YES;
    
    self.priceLab.textColor =[UIColor colorWithHex:@"#000000"];
    self.priceLab.font = AdaptedFontSize(30);

    
    //初始化一个长按手势
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
    [self.contentView addGestureRecognizer:longPressGest];
    
    // Initialization code
}


-(void)setPriceModel:(PriceModel *)priceModel{
    _priceModel = priceModel;
    
    self.fromLab.text = priceModel.platformCnName;
    self.nameLab.text =[NSString stringWithFormat:@"%@/%@",priceModel.fsym,priceModel.tsyms];
    self.volumeLab.text = [NSString stringWithFormat:@"成交量 %@",priceModel.tradingVolume];
    self.increaseLab.text = priceModel.priceChangeRatio;
    self.priceLab.text = priceModel.lastPrice;
}

-(void)longPressView:(UILongPressGestureRecognizer *)longPressGest{
    
    if (longPressGest.state==UIGestureRecognizerStateBegan) {
        
//        NSLog(@"长按手势开启");
        if (_delegate && [_delegate respondsToSelector:@selector(cellLongPress:)]) {
            [_delegate cellLongPress:self];
        }
        
    } else {
//        NSLog(@"长按手势结束");
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
