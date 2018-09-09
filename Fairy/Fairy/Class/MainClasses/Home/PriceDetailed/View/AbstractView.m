
//
//  AbstractView.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/2.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "AbstractView.h"
#import "InformationDetailsVC.h"
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
@property (nonatomic, strong) UILabel *CompanyBussDet;
@property (nonatomic, strong) UILabel *CompanyBussDet1;
@property (nonatomic, strong) UILabel *CompanyBussDet2;


@property (nonatomic, strong) UIButton *FaceBook;
@property (nonatomic, strong) UIButton *office;
@property (nonatomic, strong) UIButton *liulanq;
@property (nonatomic, strong) UIButton *witter;






@property (nonatomic,strong)NSMutableDictionary *dic;

@end
@implementation AbstractView
-(NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        [self addSubview:self.ScrollView];
        [self sutpeData];
    
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
-(void)sutpeData{
//    http://47.254.69.147:8080/interface/digital_currency/viewByshortEnName/btc
    
//    NSString *str = [NSString stringWithFormat:@"http://47.254.69.147:8080/interface/digital_currency/viewByshortEnName/%@",self.Coin];
    NSString *str = [NSString stringWithFormat:@"http://47.254.69.147:8080/interface/digital_currency/viewByshortEnName/%@",[kUserDefaults objectForKey:KchoseCoin]];

    [NetworkManage Get:str andParams:nil success:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 200) {
            self.dic = responseObject[@"data"];
            [self sutpeUI];
        }
        else{
            
        }

    } failure:^(NSError *error) {
        
    }];
    
    
}
-(void)sutpeUI{
 
    self.CompanyAddress = [[UILabel alloc]init];
    self.CompanyAddress.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyAddress.text = @"启动日期:";
    [self.ScrollView addSubview:self.CompanyAddress];
    [self.CompanyAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ScrollView.mas_top).offset(kScreenValue(30));
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
    self.CompanyTypeDet.text = self.dic[@"consensusMechanism"];
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
    
    
    self.CompanyPhoneDet = [[UILabel alloc]init];
    self.CompanyPhoneDet.numberOfLines = 0;
    self.CompanyPhoneDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyPhoneDet.text = self.dic[@"projectIntroduce"];
    
    CGFloat h2 = [CommonTool getHeightWithContent: self.CompanyPhoneDet.text width:kScreenWidth - kScreenValue(100) font:kScreenValue(14)];
    [self.ScrollView addSubview:self.CompanyPhoneDet];
    [self.CompanyPhoneDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyPhone);
        make.right.mas_equalTo(kScreenWidth - 11);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
        make.height.mas_equalTo(h2+5);
    }];
    
    self.CompanyMian = [[UILabel alloc]init];
    self.CompanyMian.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyMian.text = @"核心算法:";
    [self.ScrollView addSubview:self.CompanyMian];
    [self.CompanyMian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyPhoneDet.mas_bottom).offset(kScreenValue(30));
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


    
    ////企业内容
    
    self.CompanyAddressDet = [[UILabel alloc]init];
    self.CompanyAddressDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyAddressDet.text = [CommonTool YYMMDDtimeWithTimeIntervalString:self.dic[@"issueTime"]];
    [self.ScrollView addSubview:self.CompanyAddressDet];
    [self.CompanyAddressDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyAddress);
        make.right.mas_equalTo(kScreenWidth - 11);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    self.CompanyPeopleDet = [[UILabel alloc]init];
    self.CompanyPeopleDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyPeopleDet.text = self.dic[@"circulateNum"];
    [self.ScrollView addSubview:self.CompanyPeopleDet];
    [self.CompanyPeopleDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyPeople);
        make.right.mas_equalTo(kScreenWidth - 11);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    

  
    self.CompanyMainDet = [[UILabel alloc]init];
    self.CompanyMainDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
    self.CompanyMainDet.text = self.dic[@"coreAlgorithm"];
    [self.ScrollView addSubview:self.CompanyMainDet];
    [self.CompanyMainDet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyMian);
        make.right.mas_equalTo(kScreenWidth - 11);
        make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
        make.height.mas_equalTo(kScreenValue(14));
    }];
    
    self.office = [UIButton buttonWithType:UIButtonTypeCustom];
    self.office.titleLabel.font = [UIFont systemFontOfSize:kScreenValue(13)];
//    self.office.titleLabel.text = self.dic[@"officialUrl"];
    [self.office setTitle:@"官网" forState:UIControlStateNormal];
    [self.office setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    self.office.tag = 3000;

    self.office.layer.masksToBounds = YES;
    self.office.layer.borderWidth = 1;
    self.office.layer.borderColor = RGBA(33, 151, 216, 1).CGColor;

    CGFloat OfficeW = [CommonTool getWidthWithContent:@"官网" height:kScreenValue(14) font:kScreenValue(14)];
    
    self.office.layer.cornerRadius = kScreenValue(7);
    [self.ScrollView addSubview:self.office];
    [self.office mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyDescribe);
        make.left.equalTo(self.CompanyMainDet);
        make.width.mas_equalTo(OfficeW+10);
        make.height.mas_equalTo(kScreenValue(14));
    }];
    [self.office addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];

    self.liulanq = [UIButton buttonWithType:UIButtonTypeCustom];
    self.liulanq.titleLabel.font = [UIFont systemFontOfSize:kScreenValue(13)];
    //    self.office.titleLabel.text = self.dic[@"officialUrl"];
    [self.liulanq setTitle:@"区块链浏览器" forState:UIControlStateNormal];
    [self.liulanq setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    self.liulanq.layer.masksToBounds = YES;
    self.liulanq.layer.borderWidth = 1;
    self.liulanq.layer.borderColor = RGBA(33, 151, 216, 1).CGColor;
    self.liulanq.layer.cornerRadius = kScreenValue(7);
    self.liulanq.tag = 3001;
    CGFloat liulanqW = [CommonTool getWidthWithContent:@"区块链浏览器" height:kScreenValue(14) font:kScreenValue(14)];
    
    [self.ScrollView addSubview:self.liulanq];
    [self.liulanq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyDescribe);
        make.left.equalTo(self.office.mas_right).offset(kScreenValue(6));
        make.width.mas_equalTo(liulanqW+10);
        make.height.mas_equalTo(kScreenValue(14));
    }];
    [self.liulanq addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];

    self.witter = [UIButton buttonWithType:UIButtonTypeCustom];
    self.witter.titleLabel.font = [UIFont systemFontOfSize:kScreenValue(13)];
    //    self.office.titleLabel.text = self.dic[@"officialUrl"];
    [self.witter setTitle:@"推特" forState:UIControlStateNormal];
    self.witter.layer.cornerRadius = kScreenValue(7);
    self.witter.tag = 3002;

    [self.witter setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    CGFloat witterW = [CommonTool getWidthWithContent:@"推特" height:kScreenValue(14) font:kScreenValue(14)];
    self.witter.layer.masksToBounds = YES;
    self.witter.layer.borderWidth = 1;
    self.witter.layer.borderColor = RGBA(33, 151, 216, 1).CGColor;
    [self.ScrollView addSubview:self.witter];
    [self.witter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyDescribe);
        make.left.equalTo(self.liulanq.mas_right).offset(kScreenValue(6));
        make.width.mas_equalTo(witterW+10);
        make.height.mas_equalTo(kScreenValue(14));
    }];
    [self.witter addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];

    self.FaceBook = [UIButton buttonWithType:UIButtonTypeCustom];
    self.FaceBook.titleLabel.font = [UIFont systemFontOfSize:kScreenValue(13)];
    //    self.office.titleLabel.text = self.dic[@"officialUrl"];
    self.FaceBook.titleLabel.text = @"脸书";
    self.FaceBook.layer.cornerRadius = kScreenValue(7);
    self.FaceBook.tag = 3003;

    [self.FaceBook setTitle:@"脸书" forState:UIControlStateNormal];
    [self.FaceBook setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    CGFloat FaceBookW = [CommonTool getWidthWithContent:@"脸书" height:kScreenValue(14) font:kScreenValue(14)];
    self.FaceBook.layer.masksToBounds = YES;
    self.FaceBook.layer.borderWidth = 1;
    self.FaceBook.layer.borderColor = RGBA(33, 151, 216, 1).CGColor;
    [self.ScrollView addSubview:self.FaceBook];
    [self.FaceBook mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.CompanyDescribe);
        make.left.equalTo(self.witter.mas_right).offset(kScreenValue(6));
        make.width.mas_equalTo(FaceBookW+10);
        make.height.mas_equalTo(kScreenValue(14));
    }];
    [self.FaceBook addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (![CommonTool isNullToString:self.dic[@"recruitmentTime"]]) {
        
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
        
        self.CompanyBussDet = [[UILabel alloc]init];
        self.CompanyBussDet.font = [UIFont systemFontOfSize:kScreenValue(14)];
        self.CompanyBussDet.text = [NSString stringWithFormat:@"%@",self.dic[@"recruitmentTime"]];
        [self.ScrollView addSubview:self.CompanyBussDet];
        [self.CompanyBussDet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.CompanyBuss);
            make.right.mas_equalTo(kScreenWidth - 11);
            make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
            make.height.mas_equalTo(kScreenValue(14));
        }];
        self.CompanyBussDet1 = [[UILabel alloc]init];
        self.CompanyBussDet1.font = [UIFont systemFontOfSize:kScreenValue(14)];
        self.CompanyBussDet1.text = [NSString stringWithFormat:@"%@",self.dic[@"recruitmentRatio"]];
        [self.ScrollView addSubview:self.CompanyBussDet1];
        [self.CompanyBussDet1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.CompanyBussDet.mas_bottom).offset(kScreenValue(8));
            make.right.mas_equalTo(kScreenWidth - 11);
            make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
            make.height.mas_equalTo(kScreenValue(14));
        }];
        self.CompanyBussDet2 = [[UILabel alloc]init];
        self.CompanyBussDet2.font = [UIFont systemFontOfSize:kScreenValue(14)];
        self.CompanyBussDet2.text = [NSString stringWithFormat:@"%@",self.dic[@"recruitmentFund"]];
        [self.ScrollView addSubview:self.CompanyBussDet2];
        [self.CompanyBussDet2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.CompanyBussDet1.mas_bottom).offset(kScreenValue(8));
            make.right.mas_equalTo(kScreenWidth - 11);
            make.width.mas_equalTo(kScreenWidth - kScreenValue(100));
            make.height.mas_equalTo(kScreenValue(14));
        }];
    }
}

-(void)ClickBtn:(UIButton *)sender{
    
    InformationDetailsVC *vc =[InformationDetailsVC new];

    
    switch (sender.tag ) {
        case 3000:
            vc.url = self.dic[@"officialUrl"];

            break;
        case 3001:
            vc.url = self.dic[@"blockInquiryUrl"];

            break;
        case 3002:
            vc.url = self.dic[@"twitterUrl"];

            break;
        case 3003:
            vc.url = self.dic[@"facebookUrl"];

            break;
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [[Tool getCurrentVC].navigationController pushViewController:vc animated:YES];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
