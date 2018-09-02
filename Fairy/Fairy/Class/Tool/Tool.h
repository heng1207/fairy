//
//  Tool.h
//  zhcxuser
//
//  Created by orilme on 2017/9/1.
//  Copyright © 2017年 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tool : NSObject

//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;
//手机号校验
+ (BOOL)checkTel:(NSString *)str;
//手机号校验,不提示出错，只返回是否正确
+ (BOOL)checkTelNoHint:(NSString *)str;
//密码校验
+ (BOOL)checkPassWord:(NSString *)password;
/// 时间格式
+ (NSString *)createTime:(NSString *)date;
/// 时间格式带小时
+ (NSString *)createTimeWithAM:(NSString *)date;
+ (NSString *)createHour:(NSString *)date;
+ (NSString *)createDayWith:(NSString *)date;
+ (NSString *)createWeek:(NSString *)date;


//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;
@end
