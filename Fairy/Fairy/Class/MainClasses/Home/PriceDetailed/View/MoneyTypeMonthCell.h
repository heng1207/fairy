//
//  MoneyTypeMonthCell.h
//  Fairy
//
//  Created by 张恒 on 2018/9/1.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoneyTypeMonthCell;
@protocol MoneyTypeMonthCellDelegate <NSObject>
-(void)cellMoneyTypeMonthSelectMoneyType:(NSString*)moneyType Month:(NSString*)month Cell:(MoneyTypeMonthCell*)selectCell;

@end


@interface MoneyTypeMonthCell : UITableViewCell

@property(nonatomic,weak)id<MoneyTypeMonthCellDelegate> delegate;
@property(nonatomic,strong)UILabel *titleLab;
@end
