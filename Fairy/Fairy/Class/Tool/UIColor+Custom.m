//
//  UIColor+Custom.m
//  知秦
//
//  Created by 解勇 on 2017/7/24.
//  Copyright © 2017年 解勇. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)

+ (UIColor *)hexColorFloat:(NSString *)hexColor withAlpha:(CGFloat)alpha
{
    if ([hexColor length]<6) {
        return nil;
    }
    
    unsigned int red_, green_, blue_;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:exceptionRange]]scanHexInt:&red_];
    
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:exceptionRange]]scanHexInt:&green_];
    
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:exceptionRange]]scanHexInt:&blue_];
    
    UIColor *resultColor = [UIColor colorWithRed:(CGFloat)red_/255. green:(CGFloat)green_/255. blue:(CGFloat)blue_/255. alpha:alpha];
    return resultColor;
}

+ (UIColor *)hexColorFloat:(NSString *)hexColor
{
    return [self hexColorFloat:hexColor withAlpha:1.0];
}

+ (UIColor *)themeColor
{
    return [self hexColorFloat:@"12B7F5"];
}

+ (UIColor *)titleTextColor
{
    return [self hexColorFloat:@""];
}

+ (UIColor *)mainBlueColor
{
    return [self hexColorFloat:@"48A3FF"];
}

+ (UIColor *)mainBlueColorEnable
{
    return [self hexColorFloat:@"48A3FF" withAlpha:0.4];
}

+ (UIColor *)similarRedColor
{
//    return [self hexChangeFloat:@"D85757"];
    return [self hexColorFloat:@"FFD700"];
}

//点击文字普通
+ (UIColor *)textNormalColor
{
    return [self hexColorFloat:@"111111"];
}

+ (UIColor *)similarLightGrayColor
{
    return [self hexColorFloat:@"DDDDDD"];
}

+ (UIColor *)similarBlackColor
{
    return [self hexColorFloat:@"323232"];
}
@end
