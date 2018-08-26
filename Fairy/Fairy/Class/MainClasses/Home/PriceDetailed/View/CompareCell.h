//
//  CompareCell.h
//  Fairy
//
//  Created by 张恒 on 2018/8/25.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CompareCellDelegate <NSObject>
-(void)cellTrendClick;
-(void)cellPlatformClick;
@end

@interface CompareCell : UITableViewCell
@property(nonatomic,weak)id<CompareCellDelegate> delegate;

@end
