//
//  InformationTimeModel.m
//  Fairy
//
//  Created by 张恒 on 2018/9/2.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "InformationTimeModel.h"

@implementation InformationTimeModel

- (void)setInformationModel:(InformationModel *)informationModel{
    _informationModel = informationModel;
    
    [self createTimeModel];
}

- (void)createTimeModel
{
    _allTime = [Tool createTimeWithAM:_informationModel.publishTime];
    _hourTime =[Tool createHour:_informationModel.publishTime];
    _dayTime =[Tool createDayWith:_informationModel.publishTime];
    _weekTime = [Tool createWeek:_informationModel.publishTime];

}
@end
