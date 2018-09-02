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

-(void)setInformationTimeModel:(InformationTimeModel *)informationTimeModel{
    _informationTimeModel = informationTimeModel;
    _informationModel = informationTimeModel.informationModel;
    
    [self createTimeSubViewFrame];
    
    
}

- (void)createTimeSubViewFrame{
    if (_informationTimeModel.currentDatyFirstInfo) {
        _sectionF = CGRectMake(0, 0, SCREEN_WIDTH, 44);
        _allTime = CGRectMake(6, 0, 150, 44);
    }
    else{
        _allTime = CGRectMake(6, 0, 150, 0);
        _sectionF = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    }
    
    
    
    CGSize sizeHour = [_informationTimeModel.hourTime boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _hourTime = CGRectMake(10, CGRectGetMaxY(_allTime)+10, sizeHour.width, sizeHour.height);
    
    CGSize sizeKey = [_informationModel.key boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    //设置key frame
    _keyF = CGRectMake(CGRectGetMaxX(_hourTime)+6, CGRectGetMaxY(_allTime)+10, sizeKey.width,sizeKey.height);
    
    
    NSString *sentimentStr;
    BOOL isInt = [Tool isPureInt:_informationModel.sentiment];
    if (isInt) {
        sentimentStr = [NSString stringWithFormat:@"%@.0",_informationModel.sentiment];
    }
    else{
        float change = [_informationModel.sentiment floatValue];
        sentimentStr = [NSString stringWithFormat:@"%0.2f",change];
    }
    CGSize sentimentSize = [sentimentStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    //设置sentiment frame
    _sentimentF = CGRectMake(SCREEN_WIDTH-sentimentSize.width-10, CGRectGetMaxY(_allTime)+10, sentimentSize.width,sentimentSize.height);
    
    
    _progressF = CGRectMake(SCREEN_WIDTH-10-sentimentSize.width-5-80, CGRectGetMaxY(_allTime)+10, 80, 15);
    
    
    CGSize titleSize = [_informationModel.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20-6-sizeHour.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    //设置title frame
    _titleF = CGRectMake(CGRectGetMaxX(_hourTime)+6, CGRectGetMaxY(_keyF)+10, titleSize.width,titleSize.height);
    
    

    _lineF = CGRectMake(0, CGRectGetMaxY(_titleF) + 19, SCREEN_WIDTH, 1);
    _cellHeight = CGRectGetMaxY(_titleF) + 20;
    
}
@end
