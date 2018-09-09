//
//  PriceDataBottomCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDataBottomCell.h"
#import "FL_Button.h"
@implementation PriceDataBottomCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self) {
        
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
