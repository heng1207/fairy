//
//  PhotoSetCell.m
//  Fairy
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PhotoSetCell.h"

@implementation PhotoSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.photoLab.font = AdaptedFontSize(28);
    self.photoLab.textColor =[UIColor colorWithHex:@"#000000"];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
