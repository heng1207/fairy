//
//  BezierLineView.m
//  Fairy
//
//  Created by 张恒 on 2018/6/16.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "BezierLineView.h"

static CGRect myFrame;

@interface BezierLineView ()

@property(nonatomic,assign)float space_x; //X轴宽
@property(nonatomic,assign)float space_y; //Y轴宽
@property(nonatomic,assign)float height_X; //X轴高度


@end


@implementation BezierLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        myFrame = frame;
    }
    return self;
}


/**
 *  画折线图
 */
-(void)drawLineChartViewWithX_Value_Names:(NSMutableArray *)x_names Y_Value_Names:(NSMutableArray *)y_names TargetValues:(NSMutableArray *)targetValues LineType:(LineType)lineType{
    //1.画坐标轴
    [self drawXLine:x_names YLine:y_names];
    
    //2.获取目标值点坐标
    NSMutableArray *allPoints = [NSMutableArray array];
    for (int i=0; i<targetValues.count; i++) {
        CGFloat doubleValue = [targetValues[i] floatValue]/2;
        CGFloat X = 1.5*MARGIN + self.space_x*i;
        CGFloat Y = self.height_X -  doubleValue*_space_y;
        CGPoint point = CGPointMake(X,Y);
        [allPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    
    
    //3.坐标连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[allPoints[0] CGPointValue]];
    CGPoint PrePonit;
    switch (lineType) {
        case LineType_Straight: //直线
            for (int i =1; i<allPoints.count; i++) {
                CGPoint point = [allPoints[i] CGPointValue];
                [path addLineToPoint:point];
            }
            break;
        case LineType_Curve:   //曲线
            for (int i =0; i<allPoints.count; i++) {
                if (i==0) {
                    PrePonit = [allPoints[0] CGPointValue];
                }else{
                    CGPoint NowPoint = [allPoints[i] CGPointValue];
                    [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((PrePonit.x+NowPoint.x)/2, PrePonit.y) controlPoint2:CGPointMake((PrePonit.x+NowPoint.x)/2, NowPoint.y)]; //三次曲线
                    PrePonit = NowPoint;
                }
            }
            break;
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer];
    
    //画空心圆
    for (int i =1; i<allPoints.count; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint point = [allPoints[i] CGPointValue];
        [path addArcWithCenter:point radius:2 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor purpleColor].CGColor;
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.borderWidth = 1;
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
    }
    
    
    //    //4.添加目标值文字
    //    for (int i =0; i<allPoints.count; i++) {
    //        UILabel *label = [[UILabel alloc] init];
    //        label.textColor = [UIColor purpleColor];
    //        label.textAlignment = NSTextAlignmentCenter;
    //        label.font = [UIFont systemFontOfSize:10];
    //        [self addSubview:label];
    //
    //        if (i==0) {
    //            CGPoint NowPoint = [allPoints[0] CGPointValue];
    //            label.text = [NSString stringWithFormat:@"%.0lf",(CGRectGetHeight(myFrame)-NowPoint.y-MARGIN)/2];
    //            label.frame = CGRectMake(NowPoint.x-MARGIN/2, NowPoint.y-20, MARGIN, 20);
    //            PrePonit = NowPoint;
    //        }else{
    //            CGPoint NowPoint = [allPoints[i] CGPointValue];
    //            if (NowPoint.y<PrePonit.y) {  //文字置于点上方
    //                label.frame = CGRectMake(NowPoint.x-MARGIN/2, NowPoint.y-20, MARGIN, 20);
    //            }else{ //文字置于点下方
    //                label.frame = CGRectMake(NowPoint.x-MARGIN/2, NowPoint.y, MARGIN, 20);
    //            }
    //            label.text = [NSString stringWithFormat:@"%.0lf",(CGRectGetHeight(myFrame)-NowPoint.y-MARGIN)/2];
    //            PrePonit = NowPoint;
    //        }
    //    }
    
}



/**
 *  画坐标轴
 */
-(void)drawXLine:(NSMutableArray *)x_names YLine:(NSMutableArray *)y_names{
    
    self.space_x = (CGRectGetWidth(myFrame) -2.5*MARGIN)/ (x_names.count-1);
    self.space_y = (CGRectGetHeight(myFrame) - MARGIN - MARGIN_X)/ (y_names.count-1);
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSInteger index = [y_names indexOfObject:@"0"];
    
    //1.Y轴、X轴的直线
    [path moveToPoint:CGPointMake(1.5*MARGIN, CGRectGetHeight(myFrame)-MARGIN_X)];
    [path addLineToPoint:CGPointMake(1.5*MARGIN, MARGIN)];
    
    [path moveToPoint:CGPointMake(1.5*MARGIN, CGRectGetHeight(myFrame)-MARGIN_X - index*self.space_y)];
    self.height_X =  CGRectGetHeight(myFrame)-MARGIN_X - index*self.space_y;
    [path addLineToPoint:CGPointMake(CGRectGetWidth(myFrame)-MARGIN, CGRectGetHeight(myFrame)-MARGIN_X - index*self.space_y)];
    NSLog(@"%f---%f",myFrame.size.width,myFrame.size.height);
    
    
    
    
    //3.添加索引格
    UIBezierPath *path2 = [UIBezierPath bezierPath];//网格线
    UIBezierPath *path3 = [UIBezierPath bezierPath];//网格背景颜色
    //X轴
    for (int i=1; i<x_names.count; i++) {
        CGFloat X = 1.5*MARGIN + self.space_x*i;
        CGPoint point = CGPointMake(X,CGRectGetHeight(myFrame)-MARGIN_X);
        [path2 moveToPoint:point];
        [path2 addLineToPoint:CGPointMake(point.x, MARGIN)];
    }
    //Y轴
    for (int i=0; i<y_names.count; i++) {
        CGFloat Y = CGRectGetHeight(myFrame)-MARGIN_X-self.space_y*i;
        CGPoint point = CGPointMake(1.5*MARGIN,Y);
        [path2 moveToPoint:point];
        [path2 addLineToPoint:CGPointMake(CGRectGetWidth(myFrame)-MARGIN, point.y)];
        
        //网格背景颜色
        if ( (i%2) !=0) {
            
            [path3 moveToPoint:point];
            [path3 addLineToPoint:CGPointMake(CGRectGetWidth(myFrame)-MARGIN, point.y)];
            [path3 addLineToPoint:CGPointMake(CGRectGetWidth(myFrame)-MARGIN, point.y+self.space_y)];
            [path3 addLineToPoint:CGPointMake(1.5*MARGIN, point.y+self.space_y)];
        }
        
    }
    
    //4.添加索引格文字
    //X轴
    for (int i=0; i<x_names.count; i++) {
        CGFloat X = 1.5*MARGIN + self.space_x*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, CGRectGetHeight(myFrame)-MARGIN_X, self.space_x, 20)];
        textLabel.text = x_names[i];
        textLabel.font = [UIFont systemFontOfSize:6];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.textColor = [UIColor blackColor];
        [self addSubview:textLabel];
    }
    //Y轴
    for (int i=0; i<y_names.count; i++) {
        CGFloat Y = CGRectGetHeight(myFrame)-MARGIN_X-self.space_y*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5*MARGIN, Y-5, MARGIN, 10)];
        textLabel.text = [NSString stringWithFormat:@"%@%%",y_names[i]];
        textLabel.font = [UIFont systemFontOfSize:6];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor redColor];
        [self addSubview:textLabel];
    }
    
    //5.渲染路径
    CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.path = path3.CGPath;
    shapeLayer3.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer3.fillColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:shapeLayer3];
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = path2.CGPath;
    shapeLayer2.strokeColor = [UIColor redColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer2];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer];
    
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
