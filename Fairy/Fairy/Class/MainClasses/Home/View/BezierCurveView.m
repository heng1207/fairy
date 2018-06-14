//
//  BezierCurveView.m
//  BezierCurveLineDemo
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 xiayuanquan. All rights reserved.
//


#import "BezierCurveView.h"

static CGRect myFrame;

@interface BezierCurveView ()

@end

@implementation BezierCurveView

//初始化画布
+(instancetype)initWithFrame:(CGRect)frame{

    
    BezierCurveView *bezierCurveView = [[NSBundle mainBundle] loadNibNamed:@"BezierCurveView" owner:self options:nil].lastObject;
    bezierCurveView.frame = frame;

    //背景视图
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    NSLog(@"%f--%f",frame.size.width,frame.size.height);
    backView.backgroundColor = XYQColor(255, 229, 239);
    [bezierCurveView addSubview:backView];

    myFrame = frame;

    return bezierCurveView;
}

/**
 *  画坐标轴
 */
-(void)drawXYLine:(NSMutableArray *)x_names{
    
    UILabel *lab=[UILabel new];
    lab.text=@"历史价格:     ";
    [self addSubview:lab];
    lab.font =[UIFont systemFontOfSize:12];
    lab.frame =CGRectMake(10, 10, 100, 10);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //1.Y轴、X轴的直线
    [path moveToPoint:CGPointMake(MARGIN, CGRectGetHeight(myFrame)-MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN, MARGIN)];
    
    [path moveToPoint:CGPointMake(MARGIN, CGRectGetHeight(myFrame)-MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN+CGRectGetWidth(myFrame)-2*MARGIN, CGRectGetHeight(myFrame)-MARGIN)];
    
    //2.添加箭头
    //X轴箭头
    [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN-5, MARGIN+5)];
    [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN+5, MARGIN+5)];
    //Y轴箭头
    [path moveToPoint:CGPointMake(MARGIN+CGRectGetWidth(myFrame)-2*MARGIN, CGRectGetHeight(myFrame)-MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN+CGRectGetWidth(myFrame)-2*MARGIN-5, CGRectGetHeight(myFrame)-MARGIN-5)];
    [path moveToPoint:CGPointMake(MARGIN+CGRectGetWidth(myFrame)-2*MARGIN, CGRectGetHeight(myFrame)-MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN+CGRectGetWidth(myFrame)-2*MARGIN-5, CGRectGetHeight(myFrame)-MARGIN+5)];

    //渲染路径
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.subviews[0].layer addSublayer:shapeLayer];
    
    
    //3.添加索引格
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    //X轴
    for (int i=1; i<x_names.count; i++) {
//        CGFloat X = MARGIN + MARGIN*(i+1);
        
        CGFloat spaceX = (self.frame.size.width - 2*MARGIN)/x_names.count;
        CGFloat X = MARGIN + spaceX*i;
        
        CGPoint point = CGPointMake(X,CGRectGetHeight(myFrame)-MARGIN);
        [path2 moveToPoint:point];
        [path2 addLineToPoint:CGPointMake(point.x, MARGIN)];
    }
    //Y轴（实际长度为200,此处比例缩小一倍使用）
    float spaceY = (CGRectGetHeight(myFrame)- 2*MARGIN) /6;
    for (int i=1; i<6; i++) {
        CGFloat Y = CGRectGetHeight(myFrame)-MARGIN-spaceY*i;
        CGPoint point = CGPointMake(MARGIN,Y);
        [path2 moveToPoint:point];
        [path2 addLineToPoint:CGPointMake(CGRectGetWidth(myFrame)-MARGIN, point.y)];
    }
    //5.渲染路径
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = path2.CGPath;
    shapeLayer2.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.borderWidth = 2.0;
    [self.subviews[0].layer addSublayer:shapeLayer2];
    
    
    
    //4.添加索引格文字
    //X轴
    for (int i=0; i<x_names.count; i++) {
//        CGFloat X = MARGIN + 15 + MARGIN*i;
        CGFloat spaceX = (self.frame.size.width - 2*MARGIN)/x_names.count;
        CGFloat X = MARGIN - spaceX/2 + spaceX*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, CGRectGetHeight(myFrame)-MARGIN, spaceX, 20)];
        textLabel.text = x_names[i];
        textLabel.font = [UIFont systemFontOfSize:6];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor grayColor];
        [self addSubview:textLabel];
    }
    //Y轴
    for (int i=0; i<6; i++) {
        CGFloat Y = CGRectGetHeight(myFrame)-MARGIN-spaceY*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Y-5, MARGIN, 10)];
        textLabel.text = [NSString stringWithFormat:@"%d",200*i];
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor grayColor];
        [self addSubview:textLabel];
    }

}



/**
 *  画折线图
 */
-(void)drawLineChartViewWithX_Value_Names:(NSMutableArray *)x_names TargetValues:(NSMutableArray *)targetValues LineType:(LineType) lineType{
    
    //1.画坐标轴
    [self drawXYLine:x_names];
    
    
    
    for (NSInteger i=0; i<3; i++) {
        [self drawCurrnetPath:x_names TargetValues:targetValues[i] LineType:lineType currentLine:i];
    }
    
    
//    //4.添加目标值文字
//    for (int i =0; i<allPoints.count; i++) {
//        UILabel *label = [[UILabel alloc] init];
//        label.textColor = [UIColor purpleColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:10];
//        [self.subviews[0] addSubview:label];
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
 *  画柱状图
 */
-(void)drawBarChartViewWithX_Value_Names:(NSMutableArray *)x_names TargetValues:(NSMutableArray *)targetValues{
    
    //1.画坐标轴
    [self drawXYLine:x_names];
    
    //2.每一个目标值点坐标
    for (int i=0; i<targetValues.count; i++) {
        CGFloat doubleValue = 2*[targetValues[i] floatValue]; //目标值放大两倍
        CGFloat X = MARGIN + MARGIN*(i+1)+5;
        CGFloat Y = CGRectGetHeight(myFrame)-MARGIN-doubleValue;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(X-MARGIN/2, Y, MARGIN-10, doubleValue)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor = XYQRandomColor.CGColor;
        shapeLayer.borderWidth = 2.0;
        [self.subviews[0].layer addSublayer:shapeLayer];
        
        //3.添加文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X-MARGIN/2, Y-20, MARGIN-10, 20)];
        label.text = [NSString stringWithFormat:@"%.0lf",(CGRectGetHeight(myFrame)-Y-MARGIN)/2];
        label.textColor = [UIColor purpleColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [self.subviews[0] addSubview:label];
    }
}


/**
 *  画饼状图
 */
-(void)drawPieChartViewWithX_Value_Names:(NSMutableArray *)x_names TargetValues:(NSMutableArray *)targetValues{
    
    //设置圆点
    CGPoint point = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
    CGFloat startAngle = 0;
    CGFloat endAngle ;
    CGFloat radius = 100;
    
    //计算总数
    __block CGFloat allValue = 0;
    [targetValues enumerateObjectsUsingBlock:^(NSNumber *targetNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        allValue += [targetNumber floatValue];
    }];
    
    //画图
    for (int i =0; i<targetValues.count; i++) {
        
        CGFloat targetValue = [targetValues[i] floatValue];
        endAngle = startAngle + targetValue/allValue*2*M_PI;

        //bezierPath形成闭合的扇形路径
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:point
                                                                   radius:radius
                                                               startAngle:startAngle                                                                 endAngle:endAngle
                                                                clockwise:YES];
        [bezierPath addLineToPoint:point];
        [bezierPath closePath];
        
        
        //添加文字
        CGFloat X = point.x + 120*cos(startAngle+(endAngle-startAngle)/2) - 10;
        CGFloat Y = point.y + 110*sin(startAngle+(endAngle-startAngle)/2) - 10;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(X, Y, 30, 20)];
        label.text = x_names[i];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = XYQColor(13, 195, 176);
        [self.subviews[0] addSubview:label];
        
        
        //渲染
        CAShapeLayer *shapeLayer=[CAShapeLayer layer];
        shapeLayer.lineWidth = 1;
        shapeLayer.fillColor = XYQRandomColor.CGColor;
        shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:shapeLayer];
        
        startAngle = endAngle;
    }
}

-(void)drawCurrnetPath:(NSMutableArray *)x_names TargetValues:(NSMutableArray *)targetValues LineType:(LineType) lineType currentLine:(NSInteger) currentLine {
    //2.获取目标值点坐标
    NSMutableArray *allPoints = [NSMutableArray array];
    for (int i=0; i<targetValues.count; i++) {
        CGFloat doubleValue = 2*[targetValues[i] floatValue]; //目标值放大两倍
        //        CGFloat X = MARGIN + MARGIN*(i+1);
        CGFloat spaceX = (self.frame.size.width - 2*MARGIN)/x_names.count;//X轴间距
        CGFloat X = MARGIN + spaceX*i;
        CGFloat Y = CGRectGetHeight(myFrame)-MARGIN-doubleValue;
        CGPoint point = CGPointMake(X,Y);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x-2, point.y-2, 4, 4) cornerRadius:4];
        CAShapeLayer *layer = [CAShapeLayer layer];
        // 设置描边颜色
        layer.strokeColor = [UIColor redColor].CGColor;
        // 设置描边颜色
        layer.fillColor = [UIColor whiteColor].CGColor;
        layer.path = path.CGPath;
        [self.subviews[0].layer addSublayer:layer];
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
    if(currentLine==0){
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
    }else if (currentLine==1){
        shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    }else if (currentLine==2){
        shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.subviews[0].layer addSublayer:shapeLayer];

}

/*
 @parameter 背景颜色填充
 */
-(void)fillBackgroundColor:(NSMutableArray*)allPoints LineType:(LineType) lineType{
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
    
    
    CGFloat X = MARGIN + MARGIN*allPoints.count;
    CGPoint pointEnd = CGPointMake(X,CGRectGetHeight(myFrame)-MARGIN);
    CGPoint pointStart = CGPointMake(2*MARGIN,CGRectGetHeight(myFrame)-MARGIN);
    [path addLineToPoint:pointEnd];
    [path addLineToPoint:pointStart];
    [path addLineToPoint:[allPoints[0] CGPointValue]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor grayColor].CGColor;
    shapeLayer.borderWidth = 0;
    [self.subviews[0].layer addSublayer:shapeLayer];
    
}

@end
