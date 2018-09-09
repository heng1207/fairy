//
//  PriceCell.m
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceCell.h"

@interface PriceCell()
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *fromLab;
@property (weak, nonatomic) IBOutlet UILabel *volumeLab;
@property (weak, nonatomic) IBOutlet UILabel *increaseLab;
@property (weak, nonatomic) IBOutlet UIImageView *increaseLogo;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;


@end

@implementation PriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameLab.textColor =[UIColor colorWithHex:@"#333333"];
    self.nameLab.font = AdaptedFontSize(24);
    
    self.fromLab.textColor =[UIColor colorWithHex:@"#4b4a4a"];
    self.fromLab.font = AdaptedFontSize(24);

    
    self.volumeLab.textColor =[UIColor colorWithHex:@"#4b4a4a"];
    self.volumeLab.font = AdaptedFontSize(24);
    
    
    self.increaseLab.textColor =[UIColor colorWithHex:@"#ff1515"];
    self.increaseLab.font = AdaptedFontSize(24);
    
    
    self.priceLab.textColor =[UIColor colorWithHex:@"#333333"];
    self.priceLab.font = AdaptedFontSize(24);
    self.priceLab.numberOfLines=0;

    
    //初始化一个长按手势
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
    [self.contentView addGestureRecognizer:longPressGest];
    
    // Initialization code
}


-(void)setPriceModel:(PriceModel *)priceModel{
    _priceModel = priceModel;
    
    NSString *picUrl =[NSString stringWithFormat:@"%@%@",SERVER,priceModel.coinPicPath];
    [self.logo sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLab.text =[NSString stringWithFormat:@"%@/%@",priceModel.fsym,priceModel.tsyms];
    self.fromLab.text = priceModel.platformCnName;
    self.volumeLab.text = [NSString stringWithFormat:@"量 %@",priceModel.tradingVolume];
    self.increaseLab.text = priceModel.priceChangeRatio;
    self.priceLab.text = [NSString stringWithFormat:@"%@\n≈%@",priceModel.lastPrice,priceModel.rmbLastPrice];

    
    NSString *increaseType = [priceModel.priceChangeRatio substringToIndex:1];//截取掉下标1之前的字符串
    if ([increaseType isEqualToString:@"+"]) {
//        self.logo.image =[UIImage imageNamed:@"icon_row-b"];
        self.increaseLogo.image = [UIImage imageNamed:@"icon_rise"];
        self.increaseLab.textColor =[UIColor colorWithHex:@"#ff1515"];
    }
    else{
//        self.logo.image =[UIImage imageNamed:@"icon_row-box"];
        self.increaseLogo.image = [UIImage imageNamed:@"icon_row"];
        self.increaseLab.textColor =[UIColor colorWithHex:@"#1ca012"];
    }
    
    
    
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
