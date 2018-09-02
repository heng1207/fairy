//
//  PriceCell.h
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceModel.h"

@class PriceCell;
@protocol PriceCellDelegate <NSObject>
-(void)cellLongPress:(PriceCell*)priceCell;

@end

@interface PriceCell : UITableViewCell

@property(nonatomic,strong)PriceModel *priceModel;

@property(nonatomic,weak)id<PriceCellDelegate> delegate;
@end
