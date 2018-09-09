//
//  CommonTool.h
//  UME
//
//  Created by XY on 2018/1/12.
//  Copyright © 2018年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTool : NSObject
//是否登录
+ (BOOL)isLogin;

+ (void)MsgBox:(NSString *)msg WithView:(UIView*)view;
//判断邮箱
+ (BOOL)isValidateEmail:(NSString *)Email;
// 从身份中截取生日
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;
/**
 *  生成二维码
 */
+ (UIImage *)createQRCodeForString:(NSString *)qrString withImageViewSize:(CGSize)size;
//判断手机号
+ (BOOL)isTelePhone:(NSString*)TelePhone;
//是否为空
+ (BOOL)isNullToString:(id)string;
//获取内容的宽高
+ (CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font;
+ (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height font:(CGFloat)font;
/**
 *  限制只能输入字母和数字
 */
+ (BOOL)onlyAllowLettersAndNumbers:(NSString *)string;
/**
 *  判断是不是手机号
 */
+ (NSString *)valiMobile:(NSString *)mobile;

//时间戳转日期格式
+ (NSString *)YYMMDDtimeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)YYMMDDGGGtimeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)DDYYMMDDGGGtimeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)MMDDHHmmtimeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)YYYYMMDDHHmmtimeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)YYYYMMtimeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)YYYYMMddHHtimeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)HHmmtimeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)updateTimeForTimestamp:(NSString *)timestamp;

/**
 *  获取当前天数时间几点几分的时间戳
 *
 *  @return return 时间戳
 */
+ (NSTimeInterval)setCurrentlyDaySetHour:(NSInteger)hour setMinute:(NSInteger)minute setSec:(NSInteger)sec;

/**
 *  获取时间，并转换为字符串
 *
 *  @return return 返回字符串
 */
+ (NSString *)stringFromDateSetDateFormat:(NSString *)formatString;

//string -> attributedStr
+ (NSMutableAttributedString *)transformWithStr:(NSString *)str Index:(NSInteger)index Length:(NSInteger)length Color:(UIColor *)color;

// 设置UISearchBar背景
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (NSData *)toJSONData:(id)theData;
//图片url转image
+ (UIImage *)imageFromURLString:(NSString *)urlstring;

//yyyy-MM-dd
+ (NSMutableAttributedString *)compareCurrentTime:(NSString *)str;
+ (NSString *)compareCurrentTimeStr:(NSString *)str;
//时间差
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

+ (NSDictionary *)VEComponentsStringToDic:(NSString*)AllString withSeparateString:(NSString *)FirstSeparateString AndSeparateString:(NSString *)SecondSeparateString;

+ (UIImage *)getImageFromURL:(NSString *)fileURL;
//日期比较
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

@end
