//
//  PriceDetailedSubVC.h
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"

@interface PriceDetailedSubVC : UIViewController

@property (nonatomic,copy)NSString *coin;
-(void)loadMainTableData:(NSString*)selectType Index:(NSInteger)index  PriceModel:(PriceModel*)priceModel;
@end
