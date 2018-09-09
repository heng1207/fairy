

//
//  WaringTopCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/3.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "WaringTopCell.h"

@implementation WaringTopCell
-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.font = [UIFont systemFontOfSize:kScreenValue(14)];
        _time.textColor = [UIColor blackColor];
    }
    return _time;
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
