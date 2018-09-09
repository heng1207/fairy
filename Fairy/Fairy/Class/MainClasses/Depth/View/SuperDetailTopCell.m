//
//  SuperDetailTopCell.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/8.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "SuperDetailTopCell.h"

@implementation SuperDetailTopCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self) {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    [self.contentView addSubview:self.NowPrice];
    [self.NowPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kScreenValue(11));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(14));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-14));
        make.width.mas_equalTo(kScreenValue(14));
    }];
    [self.contentView addSubview:self.RedView];
    [self.RedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.NowPrice.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenValue(14));
        make.right.equalTo(self.contentView.mas_right).offset(kScreenValue(-14));
        //        make.width.mas_equalTo(kScreenValue(56));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(kScreenValue(-156));
    }];
    
    [self.RedView addSubview:self.NowHelp];
    [self.NowHelp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.RedView.mas_top).offset(kScreenValue(7));
        make.left.equalTo(self.RedView.mas_left).offset(kScreenValue(30));
        make.right.equalTo(self.RedView.mas_right).offset(kScreenValue(-30));
        make.width.mas_equalTo(kScreenValue(15));
    }];
    
    [self.RedView addSubview:self.UpdateTime];
    [self.UpdateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.NowHelp.mas_bottom).offset(kScreenValue(5));
        make.left.equalTo(self.RedView.mas_left).offset(kScreenValue(30));
        make.right.equalTo(self.RedView.mas_right).offset(kScreenValue(-30));
        make.width.mas_equalTo(kScreenValue(11));
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGBA(232, 239, 245, 1);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.RedView.mas_bottom).offset(kScreenValue(25));
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(kScreenValue(1));
    }];
    
    //时间列
    UILabel *time = [[UILabel alloc]init];
    time.font = [UIFont systemFontOfSize:12];
    time.textColor = [UIColor blackColor];
    time.text = @"时间";
    time.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    //超短期收益率列
    UILabel *shouyi = [[UILabel alloc]init];
    shouyi.font = [UIFont systemFontOfSize:12];
    shouyi.textColor = [UIColor blackColor];
    shouyi.text = @"预测涨幅";
    shouyi.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:shouyi];
    [shouyi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenWidth/3);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    
    
    
    //基准收益率列
    UILabel *jizhun = [[UILabel alloc]init];
    jizhun.font = [UIFont systemFontOfSize:12];
    jizhun.textColor = [UIColor blackColor];
    jizhun.text = @"实际涨幅";
    jizhun.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:jizhun];
    [jizhun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenWidth*2/3);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = RGBA(232, 239, 245, 1);
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(jizhun.mas_bottom).offset(kScreenValue(9));
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(kScreenValue(1));
    }];
    
    //第二列
    
    UILabel *time11 = [[UILabel alloc]init];
    time11.font = [UIFont systemFontOfSize:12];
    time11.textColor = [UIColor blackColor];
    time11.text = @"近2天";
    time11.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:time11];
    [time11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    
    self.shouyi1 = [[UILabel alloc]init];
    self.shouyi1.font = [UIFont systemFontOfSize:12];
//    self.shouyi1.textColor = [UIColor redColor];
    
    //    self.shouyi1.text = @"+8.11%";
    self.shouyi1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.shouyi1];
    [self.shouyi1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenWidth/3);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    
    
    
    //基准收益率列
    self.jizhun1 = [[UILabel alloc]init];
    self.jizhun1.font = [UIFont systemFontOfSize:12];
//    self.jizhun1.textColor = [UIColor redColor];
    //    self.jizhun1.text = @"-2.11%";
    self.jizhun1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.jizhun1];
    [self.jizhun1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenWidth*2/3);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = RGBA(232, 239, 245, 1);
    [self.contentView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jizhun1.mas_bottom).offset(kScreenValue(9));
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(kScreenValue(1));
    }];
    
    
    //第三列
    
    
    
    UILabel *time22 = [[UILabel alloc]init];
    time22.font = [UIFont systemFontOfSize:12];
    time22.textColor = [UIColor blackColor];
    time22.text = @"近4天";
    time22.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:time22];
    [time22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    
    
    self.shouyi2 = [[UILabel alloc]init];
    self.shouyi2.font = [UIFont systemFontOfSize:12];
//    self.shouyi2.textColor = [UIColor redColor];
    //    self.shouyi2.text = @"+8.111%";
    self.shouyi2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.shouyi2];
    [self.shouyi2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenWidth/3);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    
    
    
    //基准收益率列
    self.jizhun2 = [[UILabel alloc]init];
    self.jizhun2.font = [UIFont systemFontOfSize:12];
//    self.jizhun2.textColor = [UIColor redColor];
    //    self.jizhun2.text = @"-2.111%";
    self.jizhun2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.jizhun2];
    [self.jizhun2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenWidth*2/3);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = RGBA(232, 239, 245, 1);
    [self.contentView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.jizhun2.mas_bottom).offset(kScreenValue(9));
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(kScreenValue(1));
    }];
    
    
    UILabel *time33 = [[UILabel alloc]init];
    time33.font = [UIFont systemFontOfSize:12];
    time33.textColor = [UIColor blackColor];
    time33.text = @"近6天";
    time33.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:time33];
    [time33 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    
    
    self.shouyi3 = [[UILabel alloc]init];
    self.shouyi3.font = [UIFont systemFontOfSize:12];
//    self.shouyi3.textColor = [UIColor redColor];
    //    self.shouyi3.text = @"+8.11%";
    self.shouyi3.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.shouyi3];
    [self.shouyi3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenWidth/3);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    //
    //
    //
    //基准收益率列
    self.jizhun3 = [[UILabel alloc]init];
    self.jizhun3.font = [UIFont systemFontOfSize:12];
//    self.jizhun3.textColor = [UIColor redColor];
    //    self.jizhun3.text = @"-2.11%";
    self.jizhun3.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.jizhun3];
    [self.jizhun3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom).offset(kScreenValue(9));
        make.left.equalTo(self.contentView.mas_left).offset(kScreenWidth*2/3);
        make.width.mas_equalTo(   kScreenWidth/3);
        make.height.mas_equalTo(kScreenValue(12));
    }];
    
    
    
}

-(UILabel *)NowPrice{
    if(!_NowPrice){
        _NowPrice = [[UILabel alloc]init];
        _NowPrice.textAlignment = NSTextAlignmentCenter;
        _NowPrice.font = [UIFont systemFontOfSize:14];
        _NowPrice.textColor = [UIColor lightGrayColor];
    }
    return _NowPrice;
}
-(UIView *)RedView{
    if (!_RedView) {
        _RedView = [[UIView alloc]init];
        _RedView.layer.masksToBounds = YES;
        _RedView.layer.cornerRadius = 30;
        _RedView.backgroundColor = RGBA(243, 129, 129, 1);
    }
    return _RedView;
}
-(UILabel *)NowHelp{
    if(!_NowHelp){
        _NowHelp = [[UILabel alloc]init];
        _NowHelp.textAlignment = NSTextAlignmentCenter;
        _NowHelp.font = [UIFont systemFontOfSize:14];
        _NowHelp.textColor = [UIColor whiteColor];
    }
    return _NowHelp;
}
-(UILabel *)UpdateTime{
    if(!_UpdateTime){
        _UpdateTime = [[UILabel alloc]init];
        _UpdateTime.textAlignment = NSTextAlignmentCenter;
        _UpdateTime.font = [UIFont systemFontOfSize:11];
        _UpdateTime.textColor = [UIColor whiteColor];
    }
    return _UpdateTime;
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
