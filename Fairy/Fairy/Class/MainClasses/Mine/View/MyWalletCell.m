//
//  MyWalletCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/28.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "MyWalletCell.h"

@implementation MyWalletCell
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
    
    [self.contentView addSubview:self.count];
    [self.count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(26));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-17));
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
-(UILabel *)count{
    if (!_count) {
        _count = [[UILabel alloc]init];
        _count.font = [UIFont systemFontOfSize:kScreenValue(14)];
        _count.textColor = [UIColor redColor];
        _count.textAlignment = NSTextAlignmentRight;

    }
    return _count;
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
