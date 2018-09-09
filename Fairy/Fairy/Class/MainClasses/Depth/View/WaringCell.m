

//
//  WaringCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/3.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "WaringCell.h"
@implementation WaringCell


-(void)layoutSubviews{
    [super layoutSubviews];
    

}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.font = [UIFont systemFontOfSize:kScreenValue(14)];
    }
    return _time;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:kScreenValue(14)];
    }
    return _title;
}
-(UILabel *)connect{
    if (!_connect) {
        _connect = [[UILabel alloc]init];
        _connect.font = [UIFont systemFontOfSize:kScreenValue(14)];
        _connect.numberOfLines = 0;
    }
    return _connect;
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
