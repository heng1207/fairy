//
//  InformationFrameModel.m
//  Fairy
//
//  Created by  on 2018/8/5.
//  Copyright © 2018年 . All rights reserved.
//

#import "InformationFrameModel.h"

@implementation InformationFrameModel


- (void)setInformationModel:(InformationModel *)informationModel{
    _informationModel = informationModel;
    
    [self createSubViewFrame];
}

- (void)createSubViewFrame
{
    
    CGSize sizeKey = [_informationModel.key boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    //设置key frame
    _keyF = CGRectMake(12, 12, sizeKey.width,sizeKey.height);
    
    
    NSString *sentimentStr;
    BOOL isInt = [Tool isPureInt:_informationModel.sentiment];
    if (isInt) {
        sentimentStr = [NSString stringWithFormat:@"涨幅：%@.0",_informationModel.sentiment];
    }
    else{
        float change = [_informationModel.sentiment floatValue];
        sentimentStr = [NSString stringWithFormat:@"涨幅：%0.3f",change];
    }
    CGSize sentimentSize = [sentimentStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    //设置sentiment frame
    _sentimentF = CGRectMake(CGRectGetMaxX(_keyF)+5, 12, sentimentSize.width,sentimentSize.height);
    
    
    CGSize titleSize = [_informationModel.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    //设置title frame
    _titleF = CGRectMake(12, CGRectGetMaxY(_keyF), titleSize.width,titleSize.height);
    
    
    CGSize urlSize = [_informationModel.url boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-24, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    //设置url frame
    _urlF = CGRectMake(12, CGRectGetMaxY(_titleF), urlSize.width,urlSize.height);

    
    _lineF = CGRectMake(0, CGRectGetMaxY(_urlF) + 11, SCREEN_WIDTH, 1);
    _cellHeight = CGRectGetMaxY(_urlF) + 12;

}

@end
