//
//  YAxisView.h
//  WSLineChart
//
//  Created by iMac on 16/11/17.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDYAxisView : UIView

- (id)initWithFrame:(CGRect)frame yMax:(CGFloat)yMax yMin:(CGFloat)yMin;

- (id)initWithFrame:(CGRect)frame yMax:(CGFloat)yMax yMin:(CGFloat)yMin yMaxUnder:(CGFloat)yMaxUnder yMinUnder:(CGFloat)yMinUnder;
@end