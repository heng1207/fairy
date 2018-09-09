//
//  SuperFastBottomCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "SuperFastBottomCell.h"
@interface SuperFastBottomCell ()
@property (nonatomic,assign ) CGSize describeSize;
@property (nonatomic,assign ) CGSize dateSize;
@property (nonatomic,assign ) CGSize btcSize;
@property (nonatomic,assign ) CGSize closeSize;
@property (nonatomic,assign ) CGSize descriptionSize;
@property (nonatomic,copy ) NSString *ValueStr;
@end
@implementation SuperFastBottomCell



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
 
    [self.contentView addSubview:self.describeLab];
    [self.describeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(5));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(12));
        make.width.mas_equalTo(kScreenWidth - kScreenValue(24));
        make.height.mas_equalTo(_describeSize.height);
    }];
    
    
   
    [self.contentView addSubview:self.dateLab];
    
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.describeLab.mas_bottom).offset(kScreenValue(5));
        make.left.equalTo(self.describeLab);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(24));
        make.height.mas_equalTo(_dateSize.height);
    }];
  
    
   
    [self.contentView addSubview:self.btcLab];
    
    [self.btcLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLab.mas_bottom).offset(kScreenValue(5));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(12));
        make.width.mas_equalTo(kScreenWidth - kScreenValue(24));
        make.height.mas_equalTo(_btcSize.height);
    }];
 
    
    

    [self.contentView addSubview:self.closeLab];
    
    [self.closeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btcLab.mas_bottom).offset(kScreenValue(5));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(12));
        make.width.mas_equalTo(kScreenWidth - kScreenValue(24));
        make.height.mas_equalTo(_closeSize.height);
    }];
   
    
    
    
  
    [self.contentView addSubview:self.descriptionLab];
    
    [self.descriptionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.closeLab.mas_bottom).offset(kScreenValue(5));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(12));
        make.width.mas_equalTo(kScreenWidth - kScreenValue(24));
        make.height.mas_equalTo(_descriptionSize.height+5);
    }];
 
    [self.contentView addSubview:self.describeIM];
    
    [self.describeIM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLab.mas_bottom).offset(kScreenValue(2));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(12));
        make.width.mas_equalTo(SCREEN_WIDTH-24);
        make.height.mas_equalTo(100);
    }];
    
}

-(void)ValueForDic:(NSMutableDictionary *)dic{
    
   
    
    if (![CommonTool isNullToString:dic[@"data"][@"close"]]) {
        _ValueStr =dic[@"data"][@"close"];
    }
    if (![CommonTool isNullToString:dic[@"data"][@"oil_price"]]) {
        _ValueStr =dic[@"data"][@"oil_price"];

    }
    if (![CommonTool isNullToString:dic[@"data"][@"subscriber_growth"]]) {
        _ValueStr =dic[@"data"][@"subscriber_growth"];

    }
    if (![CommonTool isNullToString:dic[@"data"][@"exch_rate"]]) {
        _ValueStr =dic[@"data"][@"exch_rate"];

    }

    
    _describeSize = [[NSString stringWithFormat:@"%@",TL_Str_Protect(dic[@"des"])] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _dateSize = [[NSString stringWithFormat:@"日期:%@",TL_Str_Protect(dic[@"data"][@"date"])] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _btcSize = [ [NSString stringWithFormat:@"%@：%@",self.coinName,TL_Str_Protect(dic[@"data"][self.coinName])] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
     _closeSize = [ [NSString stringWithFormat:@"当前值：%@",TL_Str_Protect(_ValueStr)] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _descriptionSize =  [[NSString stringWithFormat:@"描述:%@",TL_Str_Protect(dic[@"data"][@"description"])] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",SERVER,dic[@"image"]];
    [self.describeIM sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@""]];
    self.describeLab.text = [NSString stringWithFormat:@"%@",TL_Str_Protect(dic[@"des"])];
    self.dateLab.text = [NSString stringWithFormat:@"日期:%@",TL_Str_Protect(dic[@"data"][@"date"])];
    self.btcLab.text = [NSString stringWithFormat:@"%@：%@",self.coinName,TL_Str_Protect(dic[@"data"][self.coinName])];
    self.closeLab.text = [NSString stringWithFormat:@"当前值：%@",TL_Str_Protect(_ValueStr)];
  
    self.descriptionLab.text = [NSString stringWithFormat:@"描述:%@",TL_Str_Protect(dic[@"data"][@"description"])];
    [self layoutSubviews];
}



-(UILabel *)describeLab{
    if (!_describeLab) {
        _describeLab = [[UILabel alloc]init];
        _describeLab.textColor = [UIColor blackColor];
        _describeLab.font = [UIFont systemFontOfSize:15];
        _describeLab.numberOfLines = 0;
    }
    return _describeLab;
}
-(UILabel *)dateLab{
    if (!_dateLab) {
        _dateLab = [[UILabel alloc]init];
        _dateLab.textColor = [UIColor blackColor];
        _dateLab.font = [UIFont systemFontOfSize:12];
        _dateLab.numberOfLines = 0;
    }
    return _dateLab;
}
-(UILabel *)btcLab{
    if (!_btcLab) {
        _btcLab = [[UILabel alloc]init];
        _btcLab.textColor = [UIColor blackColor];
        _btcLab.font = [UIFont systemFontOfSize:12];
        
        _btcLab.numberOfLines = 0;
        _btcLab.userInteractionEnabled =YES;
    }
    return _btcLab;
}
-(UILabel *)closeLab{
    if (!_closeLab) {
        _closeLab = [[UILabel alloc]init];
        _closeLab.textColor = [UIColor blackColor];
        _closeLab.font = [UIFont systemFontOfSize:12];
        _closeLab.numberOfLines = 0;
    }
    return _closeLab;
}
-(UILabel *)descriptionLab{
    if (!_descriptionLab) {
        _descriptionLab = [[UILabel alloc]init];
        _descriptionLab.textColor = [UIColor blackColor];
        _descriptionLab.font = [UIFont systemFontOfSize:12];
        _descriptionLab.numberOfLines = 0;
    }
    return _descriptionLab;
}
-(UIImageView *)describeIM{
    if (!_describeIM) {
        _describeIM = [[UIImageView alloc]init];
        [_describeIM setUserInteractionEnabled:YES];
    }
    return _describeIM;
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
