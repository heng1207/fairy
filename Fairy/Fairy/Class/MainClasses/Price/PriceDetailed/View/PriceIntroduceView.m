//
//  PriceIntroduceView.m
//  Fairy
//
//  Created by iOS-Mac on 2018/8/8.
//  Copyright © 2018年 张恒. All rights reserved.
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
    urlLab.textColor = [UIColor blueColor];
    urlLab.font = [UIFont systemFontOfSize:15];
    urlLab.numberOfLines = 0;
    _urlLab = urlLab;
    [self addSubview:urlLab];
    
}

-(void)setDataDic:(NSMutableDictionary *)dataDic{
    _dataDic = dataDic;
    
    _CnNameLab.text = dataDic[@"currencyCnName"];
    CGSize CnNameSize = [dataDic[@"currencyCnName"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _CnNameLab.frame = CGRectMake(12, 12, CnNameSize.width, CnNameSize.height);
    
    
    _EnNameLab.text = dataDic[@"currencyEnName"];
    CGSize EnNameSize = [dataDic[@"currencyEnName"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _EnNameLab.frame = CGRectMake(CGRectGetMaxX(_CnNameLab.frame)+5,12, EnNameSize.width, EnNameSize.height);
    
    
    NSString *dateStr =[NSString stringWithFormat:@"%@",dataDic[@"issueTime"]];
    _timeLab.text = [Tool createTimeWithAM:dateStr];
    CGSize timeSize = [_timeLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _timeLab.frame = CGRectMake(CGRectGetMaxX(_EnNameLab.frame)+5, 12, timeSize.width, timeSize.height);
    
    
    _numLab.text = dataDic[@"circulateNum"];
    CGSize numSize = [dataDic[@"circulateNum"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _numLab.frame = CGRectMake(12, CGRectGetMaxY(_CnNameLab.frame), numSize.width, numSize.height);
    
    
    _introduceLab.text = dataDic[@"projectIntroduce"];
    CGSize introduceSize = [dataDic[@"projectIntroduce"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _introduceLab.frame = CGRectMake(12, CGRectGetMaxY(_numLab.frame),  introduceSize.width, introduceSize.height);
    
    
    _urlLab.text = dataDic[@"officialUrl"];
    CGSize urlSize = [dataDic[@"officialUrl"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _urlLab.frame = CGRectMake(12, CGRectGetMaxY(_introduceLab.frame), urlSize.width, urlSize.height);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
