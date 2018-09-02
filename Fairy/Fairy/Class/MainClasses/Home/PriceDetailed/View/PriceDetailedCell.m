//
//  PriceDetailedCell.m
//  Fairy
//
//  Created by 张恒 on 2018/8/25.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDetailedCell.h"

@interface PriceDetailedCell()
@property (weak, nonatomic) IBOutlet UILabel *fromeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyiLab;
@property (weak, nonatomic) IBOutlet UILabel *chengjiaoLab;

@end

@implementation PriceDetailedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.fromeLab.textColor =[UIColor colorWithHex:@"#ffffff"];
    self.fromeLab.font = AdaptedFontSize(24);
    
    self.priceLab.textColor =[UIColor colorWithHex:@"#ffffff"];
    self.priceLab.font = AdaptedFontSize(34);
    
    self.jiaoyiLab.textColor =[UIColor colorWithHex:@"#92dcff"];
    self.jiaoyiLab.font = AdaptedFontSize(26);
    
    self.chengjiaoLab.textColor =[UIColor colorWithHex:@"#92dcff"];
    self.chengjiaoLab.font = AdaptedFontSize(26);
    
    // Initialization code
}

-(void)setModel:(PriceModel *)model{
    _model = model;
    
    self.fromeLab.text =model.platformCnName;
    self.priceLab.text =model.lastPrice;
    self.chengjiaoLab.text = [NSString stringWithFormat:@"交易量：%@", model.tradingVolume];
    self.jiaoyiLab.text = [NSString stringWithFormat:@"涨幅：%@", model.priceChangeRatio];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
