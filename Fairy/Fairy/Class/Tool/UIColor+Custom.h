//
//  UIColor+Custom.h
//  知秦
//
//  Created by 解勇 on 2017/7/24.
//  Copyright © 2017年 解勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Custom)

+ (UIColor *)hexColorFloat:(NSString *)hexColor;

+ (UIColor *)hexColorFloat:(NSString *)hexColor withAlpha:(CGFloat)alpha;
//主题色
+ (UIColor *)themeColor;
+ (UIColor *)similarRedColor;
+ (UIColor *)mainBlueColor;
+ (UIColor *)mainBlueColorEnable;

+ (UIColor *)similarLightGrayColor;
+ (UIColor *)similarBlackColor;

//点击文字普通
+ (UIColor *)textNormalColor;
//标题/昵称
+ (UIColor *)titleTextColor;

@end
