//
//  BezierCurveView.m
//  BezierDrawLine
//
//  Created by 张恒 on 2018/6/15.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "BezierCurveView.h"

static CGRect myFrame;

@interface BezierCurveView ()

@end


@implementation BezierCurveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        myFrame = frame;
    }
    return self;
}



/**
 *  画坐标轴
 */
-(void)drawXYLine:(NSMutableArray *)x_names{
    
    UILabel *lab=[UILabel new];
    lab.text=@"历史价格:";
    [self addSubview:lab];
    lab.font =[UIFont systemFontOfSize:12];
    lab.frame =CGRectMake(0.5*MARGIN, 10, 100, 10);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSLog(@"%f---%f",myFrame.size.width,myFrame.size.height);
    //1.Y轴、X轴的直线
    [path moveToPoint:CGPointMake(1.5*MARGIN, CGRectGetHeight(myFrame)-MARGIN_X)];
    [path addLineToPoint:CGPointMake(1.5*MARGIN, MARGIN)];
    
    [path moveToPoint:CGPointMake(1.5*MARGIN, CGRectGetHeight(myFrame)-MARGIN_X)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(myFrame)-MARGIN, CGRectGetHeight(myFrame)-MARGIN_X)];
    
    //2.添加箭头
//    [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
//    [path addLineToPoint:CGPointMake(MARGIN-5, MARGIN+5)];
//    [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
//    [path addLineToPoint:CGPointMake(MARGIN+5, MARGIN+5)];
//
//    [path moveToPoint:CGPointMake(MARGIN+CGRectGetWidth(myFrame)-2*MARGIN, CGRectGetHeight(myFrame)-MARGIN)];
//    [path addLineToPoint:CGPointMake(MARGIN+CGRectGetWidth(myFrame)-2*MARGIN-5, CGRectGetHeight(myFrame)-MARGIN-5)];
//    [path moveToPoint:CGPointMake(MARGIN+CGRectGetWidth(myFrame)-2*MARGIN, CGRectGetHeight(myFrame)-MARGIN)];
//    [path addLineToPoint:CGPointMake(MARGIN+CGRectGetWidth(myFrame)-2*MARGIN-5, CGRectGetHeight(myFrame)-MARGIN+5)];

    
    //3.添加索引格（网格）
    UIBezierPath *path2 = [UIBezierPath bezierPath];//网格线
    UIBezierPath *path3 = [UIBezierPath bezierPath];//网格背景颜色
    //X轴
    float space_x = (CGRectGetWidth(myFrame) -2.5*MARGIN)/ (x_names.count-1);
    for (int i=1; i<x_names.count; i++) {
        CGFloat X = 1.5*MARGIN + space_x*i;
        CGPoint point = CGPointMake(X,CGRectGetHeight(myFrame)-MARGIN_X);
        [path2 moveToPoint:point];
        [path2 addLineToPoint:CGPointMake(point.x, MARGIN)];
    }
    //Y轴
    float space_y = (CGRectGetHeight(myFrame) - MARGIN - MARGIN_X)/ 5;
    for (int i=1; i<6; i++) {
        CGFloat Y = CGRectGetHeight(myFrame)-MARGIN_X-space_y*i;
        CGPoint point = CGPointMake(1.5*MARGIN,Y);
        [path2 moveToPoint:point];
        [path2 addLineToPoint:CGPointMake(CGRectGetWidth(myFrame)-MARGIN, point.y)];
        
        
         //网格背景颜色
        if ( (i%2) !=0) {
            
            [path3 moveToPoint:point];
            [path3 addLineToPoint:CGPointMake(CGRectGetWidth(myFrame)-MARGIN, point.y)];
            [path3 addLineToPoint:CGPointMake(CGRectGetWidth(myFrame)-MARGIN, point.y+space_y)];
            [path3 addLineToPoint:CGPointMake(1.5*MARGIN, point.y+space_y)];
            
        }
    }
   
    
    
    
    
    
    //4.添加索引格文字
    //X轴
    for (int i=0; i<x_names.count; i++) {
        CGFloat X = 1.5*MARGIN + space_x*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, CGRectGetHeight(myFrame)-MARGIN_X, space_x, 20)];
        textLabel.text = x_names[i];
        textLabel.font = [UIFont systemFontOfSize:6];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.textColor = [UIColor blackColor];
        [self addSubview:textLabel];
    }
    //Y轴
    for (int i=0; i<6; i++) {
        CGFloat Y = CGRectGetHeight(myFrame)-MARGIN_X-space_y*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.5*MARGIN, Y-5, MARGIN, 10)];
        textLabel.text = [NSString stringWithFormat:@"%d",200*i];
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
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer];
    
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = path2.CGPath;
    shapeLayer2.strokeColor = [UIColor redColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer2];
}



/**
 *  画折线图
 */
-(void)drawLineChartViewWithX_Value_Names:(NSMutableArray *)x_names TargetValues:(NSMutableArray *)targetValues LineType:(LineType) lineType{
    
    //1.画坐标轴
    [self drawXYLine:x_names];
    

    for (NSInteger i=0; i<targetValues.count; i++) {
        [self drawCurrnetPath:x_names TargetValues:targetValues[i] LineType:lineType currentLine:i];
    }
    
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
        [self.layer addSublayer:shapeLayer];
        
        //3.添加文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X-MARGIN/2, Y-20, MARGIN-10, 20)];
        label.text = [NSString stringWithFormat:@"%.0lf",(CGRectGetHeight(myFrame)-Y-MARGIN)/2];
        label.textColor = [UIColor purpleColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
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
        [self addSubview:label];
        
        
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
        CGFloat doubleValue = [targetValues[i] floatValue]/200;
        float space_x = (CGRectGetWidth(myFrame) -2.5*MARGIN)/ (x_names.count-1);
        CGFloat X = 1.5*MARGIN + space_x*i;
        //        CGFloat X = MARGIN + MARGIN*(i+1);
        
        float space_y = (CGRectGetHeight(myFrame) - MARGIN - MARGIN_X)/ 5;
        CGFloat Y = CGRectGetHeight(myFrame)-MARGIN_X-doubleValue*space_y;
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
//    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    if(currentLine==0){
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
    }else if (currentLine==1){
        shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    }else if (currentLine==2){
        shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer];
    
    
    //画空心圆
    for (int i =1; i<allPoints.count; i++) {
       
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint point = [allPoints[i] CGPointValue];
        [path addArcWithCenter:point radius:2 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = [UIColor purpleColor].CGColor;
        layer.fillColor = [UIColor whiteColor].CGColor;
        layer.borderWidth = 1;
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
    }
    
    
    //4.添加目标值文字
//    for (int i =0; i<allPoints.count; i++) {
//        UILabel *label = [[UILabel alloc] init];
//        label.textColor = [UIColor purpleColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:10];
//        [self addSubview:label];
//
//        if (i==0) {
//            CGPoint NowPoint = [allPoints[0] CGPointValue];
//            //            label.text = [NSString stringWithFormat:@"%.0lf",(CGRectGetHeight(myFrame)-NowPoint.y-MARGIN)/2];
//            label.text = [NSString stringWithFormat:@"%@",targetValues[i]];
//            label.frame = CGRectMake(NowPoint.x-MARGIN/2, NowPoint.y-20, MARGIN, 20);
//            PrePonit = NowPoint;
//        }else{
//            CGPoint NowPoint = [allPoints[i] CGPointValue];
//            if (NowPoint.y<PrePonit.y) {  //文字置于点上方
//                label.frame = CGRectMake(NowPoint.x-MARGIN/2, NowPoint.y-20, MARGIN, 20);
//            }else{ //文字置于点下方
//                label.frame = CGRectMake(NowPoint.x-MARGIN/2, NowPoint.y, MARGIN, 20);
//            }
//            //            label.text = [NSString stringWithFormat:@"%.0lf",(CGRectGetHeight(myFrame)-NowPoint.y-MARGIN)/2];
//            label.text = [NSString stringWithFormat:@"%@",targetValues[i]];
//            PrePonit = NowPoint;
//        }
//    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
