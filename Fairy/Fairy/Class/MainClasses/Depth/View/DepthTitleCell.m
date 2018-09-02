//
//  DepthTitleCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/26.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "DepthTitleCell.h"

@implementation DepthTitleCell

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
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(25));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScreenValue(-25));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(14));
        make.width.mas_equalTo(kScreenValue(56));
    }];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(33));
        make.left.equalTo(self.icon.mas_right).offset(kScreenValue(15));
        make.width.mas_equalTo(kScreenValue(200));
    }];
    [self.contentView addSubview:self.twoTitle];
    [self.twoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(kScreenValue(11));
        make.left.equalTo(self.icon.mas_right).offset(kScreenValue(15));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScreenValue(-29));
        make.width.mas_equalTo(kScreenValue(200));
    }];
    
    [self.contentView addSubview:self.FreeBtn];
    [self.FreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_top).offset(kScreenValue(0));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-15));
        make.width.mas_equalTo(kScreenValue(80));
        make.height.mas_equalTo(kScreenValue(20));

    }];
    [self.contentView addSubview:self.payForDay];
    [self.payForDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoTitle.mas_top).offset(kScreenValue(0));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-15));
        make.width.mas_equalTo(kScreenValue(80));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScreenValue(-29));

    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGBA(232, 239, 245, 1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScreenValue(0));
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(kScreenValue(1));
    }];
    
   
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_yujing_tab"]];
    }
    return _icon;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:kScreenValue(17)];
        
        
    }
    return _title;
}
-(UILabel *)twoTitle{
    if (!_twoTitle) {
        _twoTitle = [[UILabel alloc]init];
        _twoTitle.font = [UIFont systemFontOfSize:kScreenValue(14)];
        _twoTitle.textColor = [UIColor lightGrayColor];
    }
    return _twoTitle;
}
-(UIButton *)FreeBtn{
    if (!_FreeBtn) {
        _FreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_FreeBtn setTitle:@"限时免费" forState:UIControlStateNormal];
        _FreeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_FreeBtn setBackgroundColor:RGBA(244, 164, 40, 1) forState:UIControlStateNormal];
        [_FreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _FreeBtn.layer.masksToBounds = YES;
        _FreeBtn.layer.cornerRadius = 10;
    }
    return _FreeBtn;
}
-(UILabel *)payForDay{
    if (!_payForDay) {
        _payForDay = [[UILabel alloc]init];
        _payForDay.textColor = [UIColor lightGrayColor];
        _payForDay.font = [UIFont systemFontOfSize:kScreenValue(14)];

            //中划线
    }
    return _payForDay;
}

- (void)awakeFromNib {
    [super awakeFromNib];
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
