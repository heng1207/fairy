//
//  Tool.m
//  zhcxuser
//
//  Created by orilme on 2017/9/1.
//  Copyright © 2017年 orilme. All rights reserved.
//

#import "Tool.h"


@implementation Tool


//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL || [string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([string isEqualToString:@""] || [string isEqualToString:@"(null)"] || [string isEqualToString:@"null"] || [string isEqualToString:@"<null>"] || [string isEqualToString:@"NULL"]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//手机号校验
+ (BOOL)checkTel:(NSString *)str {
    if ([str length] == 0) {
        //手机号为空
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"手机号不能为空" message:@"请键入手机号" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

//手机号校验,不提示出错，只返回是否正确
+ (BOOL)checkTelNoHint:(NSString *)str{
    if ([str length] == 0) {
        //手机号为空
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;

}


//密码校验
+ (BOOL)checkPassWord:(NSString *)password {
    
    if ([password length] == 0) {
        //密码为空
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"密码不能为空" message:@"请键入密码" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    
    //由字母或数字组成 6-18位密码字符串（正则）
    NSString * regex = @"^[A-Za-z0-9_]{6,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:password]) {
        return YES ;
    }else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入由字母或数字组成的6-18位密码" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
}




/// 时间格式
+ (NSString *)createTime:(NSString *)date
{
    NSDateFormatter *frm = [[NSDateFormatter alloc]init];
    
    // 时间模式本地化
    frm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 时间的转换格式
    frm.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    // 创建日期
    //    NSDate *createDate = [frm dateFromString:date];
    long long seconds = [date longLongValue] / 1000;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    // 获取现在的时间
    NSDate *now = [NSDate date];
    
    // 创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 比较两个时间的差值
    // 设置两个时间的差值要返回哪些值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDateComponents *cmp = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    // 设置时间显示的几种情况
    if ([createDate isThisYear])
    {   // 如果是今年
        if ([createDate isYestoday]) { // 如果是昨天
            frm.dateFormat = @"昨天 HH:mm";
            return [frm stringFromDate:createDate];
        }
        else if([createDate isToday])  // 如果是今天
        {
            if (cmp.hour >= 1) { // 如果是1小时以后
                return [NSString stringWithFormat:@"%ld小时前",(long)cmp.hour];
            }
            else if(cmp.minute > 1) { // 如果是一分钟以后
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmp.minute];
            }
            else
            {
                return @"刚刚";
            }
        }
        else   // 今年的其他日子（既不是今天也不是昨天）
        {
            frm.dateFormat = @"MM-dd";
            return [frm stringFromDate:createDate];
        }
    }
    else  // 非今年
    {
        frm.dateFormat = @"yyyy-MM-dd";
        return [frm stringFromDate:createDate];
    }
    
    return date;
}


//
///// 时间格式带小时
//+ (NSString *)createTimeWithAM:(NSString *)date
//{
//    NSDateFormatter *frm = [[NSDateFormatter alloc]init];
//
//    // 时间模式本地化
//    frm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//
//    // 时间的转换格式
//    frm.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
//
//    // 创建日期
//    //    NSDate *createDate = [frm dateFromString:date];
//    long long seconds = [date longLongValue] / 1000;
//    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:seconds];
//    // 获取现在的时间
//    NSDate *now = [NSDate date];
//
//    // 创建日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    // 比较两个时间的差值
//    // 设置两个时间的差值要返回哪些值
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
//    NSDateComponents *cmp = [calendar components:unit fromDate:createDate toDate:now options:0];
//
//    // 设置时间显示的几种情况
//    if ([createDate isThisYear])
//    {   // 如果是今年
//        if ([createDate isYestoday]) { // 如果是昨天
//            frm.dateFormat = @"昨天 hh:mm a";
//            return [frm stringFromDate:createDate];
//        }
//        else if([createDate isToday])  // 如果是今天
//        {
//            if (cmp.hour >= 1) { // 如果是1小时以后
//                return [NSString stringWithFormat:@"%ld小时前",(long)cmp.hour];
//            }
//            else if(cmp.minute > 1) { // 如果是一分钟以后
//                return [NSString stringWithFormat:@"%ld分钟前",(long)cmp.minute];
//            }
//            else
//            {
//                return @"刚刚";
//            }
//        }
//        else   // 今年的其他日子（既不是今天也不是昨天）
//        {
//            frm.dateFormat = @"MM-dd hh:mm a";
//            return [frm stringFromDate:createDate];
//        }
//    }
//    else  // 非今年
//    {
//        frm.dateFormat = @"yyyy-MM-dd hh:mm a";
//        return [frm stringFromDate:createDate];
//    }
//
//    return date;
//}
//



/// 时间格式带小时
+ (NSString *)createTimeWithAM:(NSString *)date
{
    NSDateFormatter *frm = [[NSDateFormatter alloc]init];
    
    // 时间模式本地化
//    frm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    frm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"]; //中文
    
    // 时间的转换格式
    frm.dateFormat = @"EEE MMM dd HH:mm yyyy";
    
    long long seconds = [date longLongValue] / 1000;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    // 设置时间显示的几种情况
    if ([createDate isThisYear])
    {   // 如果是今年
        if ([createDate isYestoday]) { // 如果是昨天
            frm.dateFormat = @"昨天 M月d号 EEEE";
            return [frm stringFromDate:createDate];
        }
        else if([createDate isToday])  // 如果是今天
        {
            
            frm.dateFormat = @"今天 M月d号 EEEE";
            return [frm stringFromDate:createDate];
      
        }
        else   // 今年的其他日子（既不是今天也不是昨天）
        {
            frm.dateFormat = @"M月d号 EEEE";
            return [frm stringFromDate:createDate];
        }
    }
    else  // 非今年
    {
        frm.dateFormat = @"yyyy年 M月d号 EEEE";
        return [frm stringFromDate:createDate];
    }
    
}


/// 时间格式带小时
+ (NSString *)createHour:(NSString *)date
{
    NSDateFormatter *frm = [[NSDateFormatter alloc]init];
    
    // 时间模式本地化
    frm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    
    // 创建日期
    long long seconds = [date longLongValue] / 1000;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:seconds];

    frm.dateFormat = @"HH:mm";
    return [frm stringFromDate:createDate];

}


/// 日期
+ (NSString *)createDayWith:(NSString *)date
{
    NSDateFormatter *frm = [[NSDateFormatter alloc]init];
    
    // 时间模式本地化
    frm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

    
    // 创建日期
    long long seconds = [date longLongValue] / 1000;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    

    frm.dateFormat = @"M月d号";
    return [frm stringFromDate:createDate];
}


///
+ (NSString *)createWeek:(NSString *)date
{
    NSDateFormatter *frm = [[NSDateFormatter alloc]init];
    
    // 时间模式本地化
//    frm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]; //英文
    frm.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"]; //中文


    // 创建日期
    long long seconds = [date longLongValue] / 1000;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:seconds];

    
    frm.dateFormat = @"EEEE";
    return [frm stringFromDate:createDate];
  

}




//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [Tool getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}



//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


@end
