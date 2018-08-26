//
//  YAxisView.m
//  WSLineChart
//
//  Created by iMac on 16/11/17.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "LDYAxisView.h"

#define xAxisTextGap 5 //x轴文字与坐标轴间隙
#define numberOfYAxisElements 5 // y轴分为几段
#define kChartLineColor         [UIColor grayColor]
#define kChartTextColor         [UIColor blackColor]


@interface LDYAxisView ()

@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;

@property (assign, nonatomic) CGFloat yMaxUnder;
@property (assign, nonatomic) CGFloat yMinUnder;

@property (assign, nonatomic) CGFloat topViewHeight;
@property (assign, nonatomic) CGFloat bottomViewHeight;

@end

@implementation LDYAxisView

- (id)initWithFrame:(CGRect)frame yMax:(CGFloat)yMax yMin:(CGFloat)yMin {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.yMax = yMax;
        self.yMin = yMin;
    
        self.topViewHeight = self.frame.size.height * 0.6;
        self.bottomViewHeight = self.frame.size.height * 0.4;
        
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame yMax:(CGFloat)yMax yMin:(CGFloat)yMin yMaxUnder:(CGFloat)yMaxUnder yMinUnder:(CGFloat)yMinUnder{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.yMax = yMax;
        self.yMin = yMin;
        
        
        self.yMaxUnder = yMaxUnder;
        self.yMinUnder = yMinUnder;
        self.topViewHeight = self.frame.size.height * 0.6;
        self.bottomViewHeight = self.frame.size.height * 0.4;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self drawTopView];
    [self drawBottomView];
}

-(void)drawTopView{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 计算坐标轴的位置以及大小
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
    
    CGSize labelSize = [@"x" sizeWithAttributes:attr];
    
    //Y轴坐标
    [self drawLine:context startPoint:CGPointMake(1, 0) endPoint:CGPointMake(1, self.frame.size.height - labelSize.height - xAxisTextGap) lineColor:[UIColor grayColor] lineWidth:1];
    
    
    NSDictionary *waterAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
  
    
    // Label做占据的高度
    CGFloat allLabelHeight = self.topViewHeight - xAxisTextGap - labelSize.height;
    // Label之间的间隙
    CGFloat labelMargin = (allLabelHeight + labelSize.height - (numberOfYAxisElements + 1) * labelSize.height) / numberOfYAxisElements;
    
    // 添加Label
    for (int i = 0; i < numberOfYAxisElements + 1; i++) {
        
        CGFloat avgValue = (self.yMax - self.yMin) / numberOfYAxisElements;
        
        // 判断是不是小数
        if ([self isPureFloat:self.yMin + avgValue * i]) {
            CGSize yLabelSize = [[NSString stringWithFormat:@"%.2f", self.yMin + avgValue * i] sizeWithAttributes:waterAttr];
            
            [[NSString stringWithFormat:@"%.2f", self.yMin + avgValue * i] drawInRect:CGRectMake( 1+5, self.topViewHeight - labelSize.height - 5 - labelMargin* i - yLabelSize.height/2, yLabelSize.width, yLabelSize.height) withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor}];
        }
        else {
            CGSize yLabelSize = [[NSString stringWithFormat:@"%.0f", self.yMin + avgValue * i] sizeWithAttributes:waterAttr];
            
            [[NSString stringWithFormat:@"%.0f", self.yMin + avgValue * i] drawInRect:CGRectMake(1+5 , self.topViewHeight - labelSize.height - 5 - labelMargin* i - yLabelSize.height/2, yLabelSize.width, yLabelSize.height) withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor}];
        }
        
    }
    
    
}

-(void)drawBottomView{
    
    // 计算坐标轴的位置以及大小
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
    
    CGSize labelSize = [@"x" sizeWithAttributes:attr];
    
    // Label做占据的高度
    CGFloat allLabelHeight = self.bottomViewHeight - xAxisTextGap - labelSize.height;
    // Label之间的间隙
    CGFloat labelMargin = (allLabelHeight + labelSize.height - (numberOfYAxisElements + 1) * labelSize.height) / numberOfYAxisElements;
    
    // 添加Label
    for (int i = 0; i < numberOfYAxisElements + 1; i++) {
        
        CGFloat avgValue = (self.yMaxUnder - self.yMinUnder) / numberOfYAxisElements;
        
        NSDictionary *waterAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
        // 判断是不是小数
        if ([self isPureFloat:self.yMinUnder + avgValue * i]) {
            CGSize yLabelSize = [[NSString stringWithFormat:@"%.2f", self.yMinUnder + avgValue * i] sizeWithAttributes:waterAttr];
            
            [[NSString stringWithFormat:@"%.2f", self.yMinUnder + avgValue * i] drawInRect:CGRectMake( 1+5, self.frame.size.height - labelSize.height - 5 - labelMargin* i - yLabelSize.height/2, yLabelSize.width, yLabelSize.height) withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor}];
        }
        else {
            CGSize yLabelSize = [[NSString stringWithFormat:@"%.0f", self.yMinUnder + avgValue * i] sizeWithAttributes:waterAttr];
            
            [[NSString stringWithFormat:@"%.0f", self.yMinUnder + avgValue * i] drawInRect:CGRectMake(1+5 , self.frame.size.height - labelSize.height - 5 - labelMargin* i - yLabelSize.height/2, yLabelSize.width, yLabelSize.height) withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor}];
        }
        
    }

    
}



// 判断是小数还是整数
- (BOOL)isPureFloat:(CGFloat)num
{
    int i = num;
    
    CGFloat result = num - i;
    
    // 当不等于0时，是小数
    return result != 0;
}

- (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width {
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);
}



@end
