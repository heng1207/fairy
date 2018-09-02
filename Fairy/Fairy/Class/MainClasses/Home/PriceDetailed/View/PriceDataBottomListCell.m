//
//  PriceDataBottomListCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/28.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDataBottomListCell.h"

@implementation PriceDataBottomListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    [self.contentView addSubview:self.one];
    [self.one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(8));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(15));
        make.width.mas_equalTo(kScreenValue(30));
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    [self.contentView addSubview:self.two];
    [self.two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.one);
        make.left.equalTo(self.one.mas_right).offset(kScreenValue(28));
        make.width.mas_equalTo(kScreenValue(70));
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    [self.contentView addSubview:self.three];
    [self.three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.one);
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(157));
        make.width.mas_equalTo(kScreenValue(65));
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    [self.contentView addSubview:self.four];
    [self.four mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.one);
        make.left.equalTo(self.three.mas_right).offset(kScreenValue(36));
        make.width.mas_equalTo(kScreenValue(42));
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    [self.contentView addSubview:self.five];
    [self.five mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.one);
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-15));
        make.width.mas_equalTo(kScreenValue(42));
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
}

-(UILabel *)one{
    if(!_one){
        _one = [[UILabel alloc]init];
        _one.font = [UIFont systemFontOfSize:kScreenValue(12)];

    }
    return _one;
}

-(UILabel *)two{
    if(!_two){
        _two = [[UILabel alloc]init];
        _two.font = [UIFont systemFontOfSize:kScreenValue(12)];
        _two.textAlignment = NSTextAlignmentCenter;

    }
    return _two;
}

-(UILabel *)three{
    if(!_three){
        _three = [[UILabel alloc]init];
        _three.font = [UIFont systemFontOfSize:kScreenValue(12)];
        _three.textAlignment = NSTextAlignmentCenter;

    }
    return _three;
}

-(UILabel *)four{
    if(!_four){
        _four = [[UILabel alloc]init];
        _four.font = [UIFont systemFontOfSize:kScreenValue(12)];
        _four.textAlignment = NSTextAlignmentCenter;

    }
    return _four;
}
-(UILabel *)five{
    if(!_five){
        _five = [[UILabel alloc]init];
        _five.font = [UIFont systemFontOfSize:kScreenValue(12)];
        _five.textAlignment = NSTextAlignmentRight;
    }
    return _five;
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
