//
//  InformationModel.h
//  Fairy
//
//  Created by  on 2018/8/3.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationModel : NSObject

@property(nonatomic,copy) NSString *publishTime;
@property(nonatomic,copy) NSString *sentiment;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *lang;
@property(nonatomic,copy) NSString *key;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *platform;


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
