//
//  PriceDataTopCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDataTopCell.h"

@implementation PriceDataTopCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(1));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-1));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(1));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScreenValue(-1));

    }];
    
     //总市值
    self.totle = [[UILabel alloc]init];
    self.totle.font = [UIFont systemFontOfSize:kScreenValue(13)];
    self.totle.textColor = RGBA(18, 150, 219, 1);
    self.totle.text = @"总市值";
    [backView addSubview:self.totle];

    [self.totle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(kScreenValue(15));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(30));
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(13));
    }];
    //数值
    self.totleCount = [[UILabel alloc]init];
    self.totleCount.font = [UIFont systemFontOfSize:kScreenValue(18)];
    self.totleCount.textColor = [UIColor blackColor];
    self.totleCount.text = @"💲2341.00";
    [backView addSubview:self.totleCount];
    
    [self.totleCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totle.mas_bottom).offset(kScreenValue(8));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(30));
        make.width.mas_equalTo(  kScreenWidth  - kScreenValue(60));
        make.height.mas_equalTo(kScreenValue(18));
    }];
    
      //成交量
    self.deal = [[UILabel alloc]init];
    self.deal.font = [UIFont systemFontOfSize:kScreenValue(11)];
    self.deal.textColor = [UIColor lightGrayColor];
    self.deal.text = @"成交量(24H)";
    [backView addSubview:self.deal];
    
    [self.deal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totleCount.mas_bottom).offset(kScreenValue(24));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(30));
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    self.dealCount = [[UILabel alloc]init];
    self.dealCount.font = [UIFont systemFontOfSize:kScreenValue(11)];
    self.dealCount.textColor = [UIColor blackColor];
    self.dealCount.text = @"427";
    [backView addSubview:self.dealCount];
    
    [self.dealCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deal.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(30));
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    
    //供应量
    self.supply = [[UILabel alloc]init];
    self.supply.font = [UIFont systemFontOfSize:kScreenValue(11)];
    self.supply.textColor = [UIColor lightGrayColor];
    self.supply.text = @"流通供应量";
    [backView addSubview:self.supply];
    
    [self.supply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deal);
        make.left.equalTo(backView.mas_left).offset(kScreenValue(142));
        make.width.mas_equalTo( kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    self.supplyCount = [[UILabel alloc]init];
    self.supplyCount.font = [UIFont systemFontOfSize:kScreenValue(11)];
    self.supplyCount.textColor = [UIColor blackColor];
    self.supplyCount.text = @"427";
    [backView addSubview:self.supplyCount];
    
    [self.supplyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deal.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(142));
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    
    


    self.MixSupply = [[UILabel alloc]init];
    self.MixSupply.font = [UIFont systemFontOfSize:kScreenValue(11)];
    self.MixSupply.textColor = [UIColor lightGrayColor];
    self.MixSupply.text = @"最大供应量";
    [backView addSubview:self.MixSupply];

    [self.MixSupply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deal);
        make.left.equalTo(backView.mas_left).offset(kScreenValue(256));
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];

    self.MixSupplyCount = [[UILabel alloc]init];
    self.MixSupplyCount.font = [UIFont systemFontOfSize:kScreenValue(11)];
    self.MixSupplyCount.textColor = [UIColor blackColor];
    self.MixSupplyCount.text = @"427";
    [backView addSubview:self.MixSupplyCount];

    [self.MixSupplyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deal.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(backView.mas_left).offset(kScreenValue(256));
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];

    
    
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
