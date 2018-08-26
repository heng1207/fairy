//
//  PriceIntroduceView.m
//  Fairy
//
//  Created by iOS-Mac on 2018/8/8.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceIntroduceView.h"

@interface PriceIntroduceView()

@property(nonatomic,strong)UILabel *CnNameLab;
@property(nonatomic,strong)UILabel *EnNameLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *numLab;
@property(nonatomic,strong)UILabel *introduceLab;
@property(nonatomic,strong)UILabel *urlLab;
@end


@implementation PriceIntroduceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor =[UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    UILabel *CnNameLab = [[UILabel alloc] init];
    CnNameLab.textColor = [UIColor blackColor];
    CnNameLab.font = [UIFont systemFontOfSize:15];
    CnNameLab.numberOfLines = 0;
    _CnNameLab = CnNameLab;
    [self addSubview:CnNameLab];
    
    
    UILabel *EnNameLab = [[UILabel alloc] init];
    EnNameLab.textColor = [UIColor blackColor];
    EnNameLab.font = [UIFont systemFontOfSize:15];
    EnNameLab.numberOfLines = 0;
    _EnNameLab = EnNameLab;
    [self addSubview:EnNameLab];
    
    
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.textColor = [UIColor blackColor];
    timeLab.font = [UIFont systemFontOfSize:15];
    _timeLab = timeLab;
    _timeLab.numberOfLines = 0;
    [self  addSubview:timeLab];
    
    
    UILabel *numLab = [[UILabel alloc] init];
    numLab.textColor = [UIColor blackColor];
    numLab.font = [UIFont systemFontOfSize:15];
    numLab.numberOfLines = 0;
    _numLab = numLab;
    [self addSubview:numLab];
    
    
    UILabel *introduceLab = [[UILabel alloc] init];
    introduceLab.textColor = [UIColor blackColor];
    introduceLab.font = [UIFont systemFontOfSize:15];
    _introduceLab = introduceLab;
    _introduceLab.numberOfLines = 0;
    [self addSubview:introduceLab];
    
    
    UILabel *urlLab = [[UILabel alloc] init];
    urlLab.textColor = [UIColor blackColor];
    urlLab.font = [UIFont systemFontOfSize:15];
    urlLab.numberOfLines = 0;
    _urlLab = urlLab;
    [self addSubview:urlLab];
    
}

-(void)setDataDic:(NSMutableDictionary *)dataDic{
    _dataDic = dataDic;
    
    _CnNameLab.text = [NSString stringWithFormat:@"中文名：%@",dataDic[@"currencyCnName"]];
    CGSize CnNameSize = [_CnNameLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _CnNameLab.frame = CGRectMake(12, 12, CnNameSize.width, CnNameSize.height);
    
    
    _EnNameLab.text = [NSString stringWithFormat:@"英文名：%@",dataDic[@"currencyEnName"]];
    CGSize EnNameSize = [_EnNameLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _EnNameLab.frame = CGRectMake(12,CGRectGetMaxY(_CnNameLab.frame)+5, EnNameSize.width, EnNameSize.height);
    
    
    NSString *dateStr =[NSString stringWithFormat:@"%@",dataDic[@"issueTime"]];
    _timeLab.text = [NSString stringWithFormat:@"发行时间：%@",[Tool createTimeWithAM:dateStr]];
    CGSize timeSize = [_timeLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _timeLab.frame = CGRectMake(12, CGRectGetMaxY(_EnNameLab.frame)+5, timeSize.width, timeSize.height);
    
    
    _numLab.text = [NSString stringWithFormat:@"流通量：%@",dataDic[@"circulateNum"]];
    CGSize numSize = [_numLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _numLab.frame = CGRectMake(12, CGRectGetMaxY(_timeLab.frame)+5, numSize.width, numSize.height);
    
    _introduceLab.text = [NSString stringWithFormat:@"介绍：%@",dataDic[@"projectIntroduce"]];
    CGSize introduceSize = [_introduceLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _introduceLab.frame = CGRectMake(12, CGRectGetMaxY(_numLab.frame)+5,  introduceSize.width, introduceSize.height);
    
    
    _urlLab.text = [NSString stringWithFormat:@"网址：%@",dataDic[@"officialUrl"]];
    CGSize urlSize = [_urlLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _urlLab.frame = CGRectMake(12, CGRectGetMaxY(_introduceLab.frame)+5, urlSize.width, urlSize.height);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
