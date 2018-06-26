//
//  SettingCell.m
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLab.font = AdaptedFontSize(30);
    self.nameLab.textColor =[UIColor colorWithHex:@"#000000"];
    self.detailLab.font = AdaptedFontSize(27);
    self.detailLab.textColor =[UIColor colorWithHex:@"#b7c0c5"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
