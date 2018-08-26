//
//  BezierView.h
//  BezierLine
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

// 线条类型
typedef NS_ENUM(NSInteger, Types) {
    Type_zhexian, // 折线
    Type_quxian     // 曲线
};


@interface BezierView : UIView

-(instancetype)initWithFrame:(CGRect)frame WithX_Value_Names:(NSMutableArray *)x_names Y_Value_Names:(NSMutableArray *)y_names TargetValues:(NSMutableArray *)targetValues Type:(Types) type;



@end
