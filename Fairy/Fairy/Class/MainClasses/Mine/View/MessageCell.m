//
//  MessageCell.m
//  Fairy
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 . All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.TitleLab.font = AdaptedFontSize(28);
    self.TitleLab.textColor =[UIColor colorWithHex:@"#000000"];
    self.DetailsLab.font = AdaptedFontSize(25);
    self.DetailsLab.textColor =[UIColor colorWithHex:@"#b9bec2"];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
