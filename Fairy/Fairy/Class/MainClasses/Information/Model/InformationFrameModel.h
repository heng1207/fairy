//
//  InformationFrameModel.h
//  Fairy
//
//  Created by  on 2018/8/5.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InformationModel.h"
#import "InformationTimeModel.h"


@interface InformationFrameModel : NSObject

@property(nonatomic,strong) InformationModel *informationModel;

@property(nonatomic,strong) InformationTimeModel *informationTimeModel;

@property (nonatomic, assign) CGRect sectionF;
/// 分区时间
@property (nonatomic, assign) CGRect allTime;

@property (nonatomic, assign) CGRect hourTime;
/// key
@property (nonatomic, assign) CGRect keyF;
/// sentiment
@property (nonatomic, assign) CGRect sentimentF;

@property (nonatomic, assign) CGRect progressF;

/// title
@property (nonatomic, assign) CGRect titleF;
/// url
@property (nonatomic, assign) CGRect urlF;


@property (nonatomic, assign) CGRect lineF;
@property(nonatomic,assign) double cellHeight;


/*
 "publishTime":1532963724000,
 "sentiment":1,
 "title":"技术葱-全球视野| XRP跌势逆转将近BTC望两周内三度上演同一剧本？ - 华尔街见闻",
 "lang":"CN",
 "key":"BTC",
 "url":"https://wallstreetcn.com/articles/3374622",
 "platform":"googlenews"
 */


@end
