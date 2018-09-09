
//
//  WallentDJCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/3.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "WallentDJCell.h"

@implementation WallentDJCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    //    [super layoutSubviews];
    
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(20));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(16));
        make.width.mas_equalTo(kScreenValue(22));
        make.height.mas_equalTo(kScreenValue(22));
        
    }];
    
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(26));
        make.left.equalTo(self.icon.mas_right).offset(kScreenValue(16));
        make.width.mas_equalTo(kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
        
    }];
    
    
    [self.contentView addSubview:self.keyong];
    [self.keyong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(26));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-16));
        make.width.mas_equalTo(kScreenValue(200));
        make.height.mas_equalTo(kScreenValue(14));
        
    }];
    [self.contentView addSubview:self.dongjie];
    [self.dongjie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.keyong.mas_bottom).offset(kScreenValue(8));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-16));
        make.width.mas_equalTo(kScreenValue(200));
        make.height.mas_equalTo(kScreenValue(14));
        
    }];

    
    
}


-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:kScreenValue(14)];
        
        
    }
    return _title;
}

-(UILabel *)keyong{
    if (!_keyong) {
        _keyong = [[UILabel alloc]init];
        _keyong.font = [UIFont systemFontOfSize:kScreenValue(14)];
        _keyong.textAlignment = NSTextAlignmentRight;
        _keyong.textColor = [UIColor redColor];
    }
    return _keyong;
}

-(UILabel *)dongjie{
    if (!_dongjie) {
        _dongjie = [[UILabel alloc]init];
        _dongjie.font = [UIFont systemFontOfSize:kScreenValue(14)];
        _dongjie.textAlignment = NSTextAlignmentRight;

        _dongjie.textColor = [UIColor redColor];
    }
    return _dongjie;
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
