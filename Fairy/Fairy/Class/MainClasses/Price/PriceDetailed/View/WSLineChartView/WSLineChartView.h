//
//  WSLineChartView.h
//  WSLineChart
//
//  Created by iMac on 16/11/17.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WSLineChartViewDelegate <NSObject>

-(void)xAxisViewCompareClick;
-(void)xAxisViewTapClick;
@end

@interface WSLineChartView : UIView

- (id)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray yMax:(CGFloat)yMax yMin:(CGFloat)yMin;

@property(nonatomic,weak)id<WSLineChartViewDelegate> delegate;


@end
