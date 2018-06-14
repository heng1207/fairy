//
//  NSDate+Extension.m
//
//
//  Created by 唐丽 on 14-10-18.
//  Copyright (c) 2014年 itcase. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断这个时间是否是今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *createCmp = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmp = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return createCmp.year == nowCmp.year;
}

/**
 *  判断这个时间是否是昨天(只比较年月日的情况了，因此可以把发微博的时间和现在的时间的时分秒都设置为0)
 */
- (BOOL)isYestoday
{
    // 把调用此方法得时间和当前时间转化为只有年月日得情况(即清空时分秒)
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    // 微博
    NSString *newStr = [fmt stringFromDate:self];
    // 现在
    NSString *newNow = [fmt stringFromDate:[NSDate date]];
    
    // 把只有年月日的字符串转换为NSDate类型了，这时它的时分秒都为0了
    // 微博
    NSDate *newDate = [fmt dateFromString:newStr];
    // 现在
    NSDate *nowDate = [fmt dateFromString:newNow];
    
    // 比较以上两个时间的差值
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmp = [calendar components:unit fromDate:newDate toDate:nowDate options:0];
    return cmp.year == 0 && cmp.month == 0 && cmp.day == 1;
}

/**
 *  判断这个时间是否是今天(只比较年月日的情况了，因此可以把发微博的时间和现在的时间的时分秒都设置为0)
 */
- (BOOL)isToday
{
    // 把调用此方法得时间和当前时间转化为只有年月日得情况(即清空时分秒)
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    // 微博
    NSString *newStr = [fmt stringFromDate:self];
    // 现在
    NSString *newNow = [fmt stringFromDate:[NSDate date]];
    
    // 只需比较这两个字符串是否相等,如果相等返回YES，即是今天
    return [newStr isEqualToString:newNow];
}

@end
