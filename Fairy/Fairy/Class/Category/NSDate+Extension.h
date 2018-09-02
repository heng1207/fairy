//
//  NSDate+Extension.h
//  
//
//  Created by 唐丽 on 14-10-18.
//  Copyright (c) 2014年 itcase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  判断这个时间是否是今年
 */
- (BOOL)isThisYear;

/**
 *  判断这个时间是否是昨天
 */
- (BOOL)isYestoday;

/**
 *  判断这个时间是否是今天
 */
- (BOOL)isToday;

@end
