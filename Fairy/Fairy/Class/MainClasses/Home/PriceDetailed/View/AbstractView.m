
//
//  AbstractView.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/2.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "AbstractView.h"
@interface AbstractView ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *ScrollView;
@property (nonatomic, strong) UILabel *Company;

@property (nonatomic, strong) UILabel *CompanyAddress;
@property (nonatomic, strong) UILabel *CompanyAddressDet;

@property (nonatomic, strong) UILabel *CompanyPeople;
@property (nonatomic, strong) UILabel *CompanyPeopleDet;

@property (nonatomic, strong) UILabel *CompanyType;
@property (nonatomic, strong) UILabel *CompanyTypeDet;

@property (nonatomic, strong) UILabel *CompanyPhone;
@property (nonatomic, strong) UILabel *CompanyPhoneDet;

@property (nonatomic, strong) UILabel *CompanyMian;
@property (nonatomic, strong) UILabel *CompanyMainDet;

@property (nonatomic, strong) UILabel *CompanyDescribe;
@property (nonatomic, strong) UILabel *CompanyDescribeDet;

@property (nonatomic, strong) UILabel *CompanyDo;
@property (nonatomic, strong) UILabel *CompanyDoDet;

@property (nonatomic, strong) UILabel *CompanyBuss;
@property (nonatomic, strong) UIImageView *CompanyBussImage;


@end
@implementation AbstractView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        [self addSubview:self.ScrollView];
        [self sutpeUI];
    }
    return self;
}
-(UIScrollView *)ScrollView{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ScrollView.delegate = self;
    }
    return _ScrollView;
}
-(void)sutpeUI{
 
    self.CompanyAddress = [[UILabel alloc]init];
    self.CompanyAddress.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyAddress.text = @"启动日期:";
    [self.ScrollView addSubview:self.CompanyAddress];
    [self.CompanyAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ScrollView.mas_top).offset(kScreenValue(24));
        make.left.equalTo(self.ScrollView.mas_left).offset(kScreenValue(15));
        make.width.mas_equalTo(kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    self.CompanyPeople = [[UILabel alloc]init];
    self.CompanyPeople.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyPeople.text = @"发行总量:";
    [self.ScrollView addSubview:self.CompanyPeople];
    [self.CompanyPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyAddress.mas_bottom).offset(kScreenValue(30));
        make.left.equalTo(self.ScrollView.mas_left).offset(kScreenValue(18));
        make.width.mas_equalTo(kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    self.CompanyType = [[UILabel alloc]init];
    self.CompanyType.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyType.text = @"共识机制:";
    [self.ScrollView addSubview:self.CompanyType];
    [self.CompanyType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyPeople.mas_bottom).offset(kScreenValue(30));
        make.left.equalTo(self.ScrollView.mas_left).offset(kScreenValue(18));
        make.width.mas_equalTo(kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    self.CompanyTypeDet = [[UILabel alloc]init];
    self.CompanyTypeDet.numberOfLines = 0;
    self.CompanyTypeDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyTypeDet.text = @"瑞波币是Ripple网络的基础货币，它可以 在整个ripple网络中流通，总数量为1000 亿，并且随着交易的增多而逐渐减少，瑞 波币的运营公司为Ripple Labs(其前身为 OpenCoin)。";
    CGFloat h = [CommonTool getHeightWithContent: self.CompanyTypeDet.text width:kScreenWidth - kScreenValue(100) font:kScreenValue(14)];
    [self.ScrollView addSubview:self.CompanyTypeDet];
    [self.CompanyTypeDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyType);
        make.right.mas_equalTo(kScreenWidth - 11);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
        make.height.mas_equalTo(h);
    }];
    
    
    self.CompanyPhone = [[UILabel alloc]init];
    self.CompanyPhone.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyPhone.text = @"币种介绍:";
    [self.ScrollView addSubview:self.CompanyPhone];
    [self.CompanyPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyTypeDet.mas_bottom).offset(kScreenValue(30));
        make.left.equalTo(self.ScrollView.mas_left).offset(kScreenValue(18));
        make.width.mas_equalTo(kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    self.CompanyMian = [[UILabel alloc]init];
    self.CompanyMian.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyMian.text = @"核心算法:";
    [self.ScrollView addSubview:self.CompanyMian];
    [self.CompanyMian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyPhone.mas_bottom).offset(kScreenValue(30));
        make.left.equalTo(self.ScrollView.mas_left).offset(kScreenValue(18));
        make.width.mas_equalTo(kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    self.CompanyDescribe = [[UILabel alloc]init];
    self.CompanyDescribe.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyDescribe.text = @"链接:";
    [self.ScrollView addSubview:self.CompanyDescribe];
    [self.CompanyDescribe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyMian.mas_bottom).offset(kScreenValue(30));
        make.left.equalTo(self.ScrollView.mas_left).offset(kScreenValue(18));
        make.width.mas_equalTo(kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];

    self.CompanyBuss = [[UILabel alloc]init];
    self.CompanyBuss.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyBuss.text = @"公募:";
    [self.ScrollView addSubview:self.CompanyBuss];
    [self.CompanyBuss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyDescribe.mas_bottom).offset(kScreenValue(30));
        make.left.equalTo(self.ScrollView.mas_left).offset(kScreenValue(18));
        make.width.mas_equalTo(kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    ////企业内容
    
    self.CompanyAddressDet = [[UILabel alloc]init];
    self.CompanyAddressDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyAddressDet.text = @"2018-05-23";
    [self.ScrollView addSubview:self.CompanyAddressDet];
    [self.CompanyAddressDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyAddress);
        make.right.mas_equalTo(kScreenWidth - 11);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    self.CompanyPeopleDet = [[UILabel alloc]init];
    self.CompanyPeopleDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyPeopleDet.text = @"2.152亿";
    [self.ScrollView addSubview:self.CompanyPeopleDet];
    [self.CompanyPeopleDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyPeople);
        make.right.mas_equalTo(kScreenWidth - 11);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    

    
    self.CompanyPhoneDet = [[UILabel alloc]init];
    self.CompanyPhoneDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyPhoneDet.text = @"Ripple实质上是一个实时结算系";
    [self.ScrollView addSubview:self.CompanyPhoneDet];
    [self.CompanyPhoneDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyPhone);
        make.right.mas_equalTo(kScreenWidth - 11);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    self.CompanyMainDet = [[UILabel alloc]init];
    self.CompanyMainDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyMainDet.text = @"官网";
    [self.ScrollView addSubview:self.CompanyMainDet];
    [self.CompanyMainDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyPhone.mas_bottom).offset(kScreenValue(10));
        make.right.mas_equalTo(kScreenWidth - 11);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
