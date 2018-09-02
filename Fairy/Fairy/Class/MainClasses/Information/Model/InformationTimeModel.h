//
//  InformationTimeModel.h
//  Fairy
//
//  Created by 张恒 on 2018/9/2.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InformationModel.h"


@interface InformationTimeModel : NSObject

@property(nonatomic,strong) InformationModel *informationModel;


@property(nonatomic,copy) NSString *allTime;
@property(nonatomic,copy) NSString *hourTime;
@property(nonatomic,copy) NSString *dayTime;
@property(nonatomic,copy) NSString *weekTime;
@property(nonatomic,assign) BOOL currentDatyFirstInfo;


@end
