//
//  TrendVC.h
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"


@interface TrendVC : UIViewController
@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerController *pagerController;
@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,strong) PriceModel *priceModel;

@end
