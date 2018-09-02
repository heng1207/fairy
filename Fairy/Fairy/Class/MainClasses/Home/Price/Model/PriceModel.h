//
//  PriceModel.h
//  Fairy
//
//  Created by on 2018/7/30.
//  Copyright © 2018年 . All rights reserved.
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
@property(nonatomic,copy) NSString *rmbLastPrice;


@end
