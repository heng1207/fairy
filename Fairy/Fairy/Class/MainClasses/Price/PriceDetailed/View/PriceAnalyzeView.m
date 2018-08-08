//
//  PriceAnalyzeView.m
//  Fairy
//
//  Created by iOS-Mac on 2018/8/6.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceAnalyzeView.h"

@interface PriceAnalyzeView()

@property(nonatomic,strong)UILabel *describeLab;
@property(nonatomic,strong)UILabel *dateLab;
@property(nonatomic,strong)UILabel *btcLab;
@property(nonatomic,strong)UILabel *closeLab;
@property(nonatomic,strong)UIImageView *describeIM;

@property(nonatomic,strong)NSString *fenXiStr;

@end

@implementation PriceAnalyzeView 

-(instancetype)initWithFrame:(CGRect)frame FenXi:(NSString *)fenXi{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.fenXiStr = fenXi;
        self.backgroundColor =[UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    UILabel *describeLab = [[UILabel alloc] init];
    describeLab.textColor = [UIColor blackColor];
    describeLab.font = [UIFont systemFontOfSize:15];
    describeLab.numberOfLines = 0;
    _describeLab = describeLab;
    [self addSubview:describeLab];
    
    
    UILabel *dateLab = [[UILabel alloc] init];
    dateLab.textColor = [UIColor blackColor];
    dateLab.font = [UIFont systemFontOfSize:15];
    dateLab.numberOfLines = 0;
    _dateLab = dateLab;
    [self addSubview:dateLab];
    

    UILabel *btcLab = [[UILabel alloc] init];
    btcLab.textColor = [UIColor blueColor];
    btcLab.font = [UIFont systemFontOfSize:15];
    _btcLab = btcLab;
    _btcLab.numberOfLines = 0;
    _btcLab.userInteractionEnabled =YES;
    [self  addSubview:btcLab];
    
    
    UILabel *closeLab = [[UILabel alloc] init];
    closeLab.textColor = [UIColor blackColor];
    closeLab.font = [UIFont systemFontOfSize:15];
    closeLab.numberOfLines = 0;
    _closeLab = closeLab;
    [self addSubview:closeLab];
    
    
    UIImageView *describeIM =[[UIImageView alloc]init];
    _describeIM = describeIM;
    [self addSubview:describeIM];
    
}

-(void)setDataDic:(NSMutableDictionary *)dataDic{
    _dataDic = dataDic;
    
    /*
     {
     "code": 200,
     "message": "操作成功",
     "data": {
     "image": "/image/statistics/Statistics_googlevscoin_btc.png",
     "data": {
     "date": "2018-08-01",
     "btc": "0.04923597542130377",
     "close": "0.3657735939366355"
     }
     }
     }
     */
    
    
    _describeLab.text = self.fenXiStr;
    CGSize describeSize = [self.fenXiStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _describeLab.frame = CGRectMake(12, 12, describeSize.width, describeSize.height);
    
    
    _dateLab.text = dataDic[@"data"][@"date"];
    CGSize dateSize = [dataDic[@"data"][@"date"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _dateLab.frame = CGRectMake(12, CGRectGetMaxY(_describeLab.frame), dateSize.width, dateSize.height);
    
    
    _btcLab.text = dataDic[@"data"][@"btc"];
    CGSize btcSize = [dataDic[@"data"][@"btc"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _btcLab.frame = CGRectMake(12, CGRectGetMaxY(_dateLab.frame), btcSize.width, btcSize.height);
    
    
    _closeLab.text = dataDic[@"data"][@"close"];
    CGSize closeSize = [dataDic[@"data"][@"close"] boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _closeLab.frame = CGRectMake(12, CGRectGetMaxY(_btcLab.frame), closeSize.width, closeSize.height);
    
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",SERVER,dataDic[@"image"]];
    [_describeIM sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@""]];
    _describeIM.frame = CGRectMake(12, CGRectGetMaxY(_closeLab.frame), SCREEN_WIDTH-24, 150);

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
