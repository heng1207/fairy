//
//  UIView+BorderLine.h
//  Fairy
//
//  Created by mac on 2018/6/13.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <UIKit/UIKit.h>
/// 边框类型(位移枚举)
typedef NS_ENUM(NSInteger, UIBorderSideType) {
    UIBorderSideTypeAll    = 0,
    UIBorderSideTypeTop    = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft   = 1 << 2,
    UIBorderSideTypeRight  = 1 << 3,
};


@interface UIView (BorderLine)
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;
@end
