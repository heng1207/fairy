//
//  PriceModel.h
//  Fairy
//
//  Created by 张恒 on 2018/7/30.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceModel : NSObject

@property(nonatomic,copy) NSString *coinPairID;
@property(nonatomic,copy) NSString *fsym;
@property(nonatomic,copy) NSString *tsyms;
@property(nonatomic,copy) NSString *platformCnName;
@property(nonatomic,copy) NSString *tradingVolume;
@property(nonatomic,copy) NSString *priceChangeRatio;
@property(nonatomic,copy) NSString *lastPrice;

@end
