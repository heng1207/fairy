//
//  PriceCell.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceCell.h"

@implementation PriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%f---%f",self.width,self.height);//320.000000---80.000000
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
