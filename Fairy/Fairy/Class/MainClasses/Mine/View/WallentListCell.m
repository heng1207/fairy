
//
//  WallentListCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/29.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "WallentListCell.h"
#import "XuXianView.h"
@implementation WallentListCell
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
    
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(26));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(25));
        make.width.mas_equalTo(kScreenValue(60));
        make.height.mas_equalTo(kScreenValue(15));
        
    }];
    
    
    
    [self.contentView addSubview:self.state];
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(26));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-25));
        make.width.mas_equalTo(kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(15));
        
    }];
    
    
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(kScreenValue(10));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(25));
        make.width.mas_equalTo(kScreenValue(kScreenWidth - kScreenValue(50)));
        make.height.mas_equalTo(kScreenValue(14));
        
    }];
    
    
    XuXianView *lineView = [[XuXianView alloc] init];
    lineView.backgroundColor = [UIColor similarLightGrayColor];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.time.mas_bottom).offset(kScreenValue(15));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(0));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(0));
        make.height.mas_equalTo(kScreenValue(1));
    }];
    
    
    
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(kScreenValue(18));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(25));
        make.width.mas_equalTo(kScreenValue(kScreenWidth - kScreenValue(50)));
        make.height.mas_equalTo(kScreenValue(14));
        
    }];
    
    [self.contentView addSubview:self.address];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(kScreenValue(18));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-25));
        make.width.mas_equalTo(kScreenValue((kScreenWidth - kScreenValue(50))/2));
        make.height.mas_equalTo(kScreenValue(14));
        
    }];
    
    [self.contentView addSubview:self.moneyCount];
    [self.moneyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.money.mas_bottom).offset(kScreenValue(15));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(25));
        make.width.mas_equalTo(kScreenValue((kScreenWidth - kScreenValue(50))/2));
        make.height.mas_equalTo(kScreenValue(14));
        
    }];
    
    [self.contentView addSubview:self.addressDetail];
    [self.addressDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.money.mas_bottom).offset(kScreenValue(15));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-25));
        make.width.mas_equalTo((kScreenWidth - kScreenValue(80)));
        make.height.mas_equalTo(kScreenValue(14));
        
    }];
    
    
    
    
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont systemFontOfSize:15];
    }
    return _title;
}
-(UILabel *)state{
    if (!_state) {
        _state = [[UILabel alloc]init];
        _state.textColor = [UIColor lightGrayColor];
        _state.font = [UIFont systemFontOfSize:15];
    }
    return _state;
}
-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.textColor = [UIColor lightGrayColor];
        _time.font = [UIFont systemFontOfSize:14];
    }
    return _time;
}
-(UILabel *)money{
    if (!_money) {
        _money = [[UILabel alloc]init];
        _money.textColor = [UIColor lightGrayColor];
        _money.font = [UIFont systemFontOfSize:14];
    }
    return _money;
}
-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc]init];
        _address.textColor = [UIColor lightGrayColor];

        _address.font = [UIFont systemFontOfSize:14];
    }
    return _address;
}
-(UILabel *)moneyCount{
    if (!_moneyCount) {
        _moneyCount = [[UILabel alloc]init];
        _moneyCount.textColor = [UIColor lightGrayColor];
        _moneyCount.font = [UIFont systemFontOfSize:18];
    }
    return _moneyCount;
}
-(UILabel *)addressDetail{
    if (!_addressDetail) {
        _addressDetail = [[UILabel alloc]init];
        _addressDetail.textColor = [UIColor lightGrayColor];
        _addressDetail.font = [UIFont systemFontOfSize:13];
        _addressDetail.textAlignment = NSTextAlignmentRight;
    }
    return _addressDetail;
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
