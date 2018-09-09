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
@property(nonatomic,strong)UILabel *descriptionLab;

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
    dateLab.font = [UIFont systemFontOfSize:12];
    dateLab.numberOfLines = 0;
    _dateLab = dateLab;
    [self addSubview:dateLab];
    

    UILabel *btcLab = [[UILabel alloc] init];
    btcLab.textColor = [UIColor blackColor];
    btcLab.font = [UIFont systemFontOfSize:12];
    _btcLab = btcLab;
    _btcLab.numberOfLines = 0;
    _btcLab.userInteractionEnabled =YES;
    [self  addSubview:btcLab];
    
    
    UILabel *closeLab = [[UILabel alloc] init];
    closeLab.textColor = [UIColor blackColor];
    closeLab.font = [UIFont systemFontOfSize:12];
    closeLab.numberOfLines = 0;
    _closeLab = closeLab;
    [self addSubview:closeLab];
    
    
    UILabel *descriptionLab = [[UILabel alloc] init];
    descriptionLab.textColor = [UIColor blackColor];
    descriptionLab.font = [UIFont systemFontOfSize:12];
    descriptionLab.numberOfLines = 0;
    _descriptionLab = descriptionLab;
    [self addSubview:descriptionLab];

    
    UIImageView *describeIM =[[UIImageView alloc]init];
    _describeIM = describeIM;
    [self addSubview:describeIM];
    [describeIM setUserInteractionEnabled:YES];

    
    

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
    

    _dateLab.text = [NSString stringWithFormat:@"date:%@",TL_Str_Protect(dataDic[@"data"][@"date"])];
    CGSize dateSize = [_dateLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _dateLab.frame = CGRectMake(12, CGRectGetMaxY(_describeLab.frame)+5, dateSize.width, dateSize.height);
    
    
    _btcLab.text = [NSString stringWithFormat:@"btc：%@",TL_Str_Protect(dataDic[@"data"][@"btc"])];
    CGSize btcSize = [_btcLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _btcLab.frame = CGRectMake(12, CGRectGetMaxY(_dateLab.frame)+5, btcSize.width, btcSize.height);
    
    
    _closeLab.text = [NSString stringWithFormat:@"close：%@",TL_Str_Protect(dataDic[@"data"][@"close"])];
    CGSize closeSize = [_closeLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _closeLab.frame = CGRectMake(12, CGRectGetMaxY(_btcLab.frame)+5, closeSize.width, closeSize.height);


    _descriptionLab.text = [NSString stringWithFormat:@"descriptione:%@",TL_Str_Protect(dataDic[@"data"][@"descriptione"])];
                                                                                                               
    CGSize descriptionSize = [_descriptionLab.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _descriptionLab.frame = CGRectMake(12, CGRectGetMaxY(_closeLab.frame)+5, descriptionSize.width, descriptionSize.height);
    

    
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",SERVER,dataDic[@"image"]];
    _imageurl = imageURL;
    [_describeIM sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@""]];
    _describeIM.frame = CGRectMake(12, CGRectGetMaxY(_descriptionLab.frame), SCREEN_WIDTH-24, 120);

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
