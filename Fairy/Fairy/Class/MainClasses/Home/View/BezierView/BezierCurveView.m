//
//  BezierCurveView.m
//  BezierDrawLine
//
//  Created by 张恒 on 2018/6/15.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "BezierCurveView.h"

#define MARGIN_Top             5   //上间隔
#define MARGIN_Bottom          15   //下间隔


@interface BezierCurveView ()

@property(nonatomic,assign)float space_y; //Y轴宽
@property(nonatomic,assign)float height_X; //X轴高度

@property(nonatomic,assign)CGRect myFrame;
@property(nonatomic,strong)NSMutableArray *x_names;
@property(nonatomic,strong)NSMutableArray *y_names;
@property(nonatomic,strong)NSMutableArray *targetValues;
@property(nonatomic,assign)LineTypes type;

@property(nonatomic,strong)NSMutableArray *shapeArr;//CAShapeLayer数组
@end


@implementation BezierCurveView

-(instancetype)initWithFrame:(CGRect)frame WithX_Value_Names:(NSMutableArray *)x_names Y_Value_Names:(NSMutableArray *)y_names TargetValues:(NSMutableArray *)targetValues LineType:(LineTypes)lineType Space_x:(float)space_x{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myFrame = frame;
        self.x_names = x_names;
        self.y_names = y_names;
        self.targetValues = targetValues;
        self.type = lineType;
        self.shapeArr = [NSMutableArray array];
        
        [self drawLineSpace_x:space_x];
    }
    return self;
}



/**
 *  画折线图
 */
-(void)drawLineSpace_x:(float)space_x{

    //1.画坐标轴
    [self drawXLineSpace_x:space_x];
    
    
    for (NSInteger i=0; i<self.targetValues.count; i++) {
        [self drawCurrnetPath:self.targetValues[i] CurrentLine:i Space_x:space_x];
    }

    
}



/**
 *  画坐标轴
 */
-(void)drawXLineSpace_x:(float)space_x{

    self.space_y = (CGRectGetHeight(self.myFrame) - MARGIN_Top - MARGIN_Bottom)/ (self.y_names.count-1);
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //判断Y轴坐标是否有0
    NSInteger index = 0;
    BOOL isbool = [self.y_names containsObject: @"0"];
    if (isbool) {
        index = [self.y_names indexOfObject:@"0"];
    }
   
    //1.X轴的直线
    [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.myFrame)-MARGIN_Bottom - index*self.space_y)];
    self.height_X =  CGRectGetHeight(self.myFrame)-MARGIN_Bottom - index*self.space_y;
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.myFrame), CGRectGetHeight(self.myFrame)-MARGIN_Bottom - index*self.space_y)];
    
    
    
    //2.添加Y轴索引格
    UIBezierPath *path2 = [UIBezierPath bezierPath];//网格线
    for (int i=0; i<self.y_names.count; i++) {
        CGFloat Y = CGRectGetHeight(self.myFrame)-MARGIN_Bottom-self.space_y*i;
        CGPoint point = CGPointMake(0,Y);
        [path2 moveToPoint:point];
        [path2 addLineToPoint:CGPointMake(CGRectGetWidth(self.myFrame), point.y)];
        
    }
    
    //4.添加索引格文字
    //X轴
    for (int i=0; i<self.x_names.count; i++) {
        CGFloat X;
        if (i== self.x_names.count-1) {
            X = space_x*i - 20;
        }
        else{
            X = space_x*i;
        }
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, CGRectGetHeight(self.myFrame)-MARGIN_Bottom, 20, 20)];
        textLabel.text = self.x_names[i];
        textLabel.font = [UIFont systemFontOfSize:6];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.textColor = [UIColor blackColor];
        [self addSubview:textLabel];
    }

    //5.渲染路径
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.path = path2.CGPath;
    shapeLayer2.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer2];
    [self.shapeArr addObject:shapeLayer2];

    
  
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.layer addSublayer:shapeLayer];
    [self.shapeArr addObject:shapeLayer];

    
}

-(void)drawCurrnetPath:(NSMutableArray *)targetValues CurrentLine:(NSInteger) currentLine Space_x:(float)space_x{
    
    //2.获取目标值点坐标
    NSMutableArray *allPoints = [NSMutableArray array];
    for (int i=0; i<targetValues.count; i++) {
        CGFloat doubleValue = [targetValues[i] floatValue] /200;//第一个2为Y轴最下面的值，第一个2为Y轴每间隔代表的值
        CGFloat X = space_x*i;
        CGFloat Y = self.height_X -  (doubleValue-1)*_space_y;
        CGPoint point = CGPointMake(X,Y);
        [allPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    
    
    //3.坐标连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[allPoints[0] CGPointValue]];
    CGPoint PrePonit;
    switch (self.type) {
        case LineType_zhexian: //直线
            for (int i =1; i<allPoints.count; i++) {
                CGPoint point = [allPoints[i] CGPointValue];
                [path addLineToPoint:point];
            }
            break;
        case LineType_quxian:   //曲线
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
    [self.layer addSublayer:shapeLayer];
    [self.shapeArr addObject:shapeLayer];

    
    //4.画空心圆
    for (int i =0; i<allPoints.count; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint point = [allPoints[i] CGPointValue];
        if (i==0) {
            CGPoint currentPoint = CGPointMake(point.x+2, point.y);
            [path addArcWithCenter:currentPoint radius:2 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        }
        else if (i==allPoints.count-1){
            CGPoint currentPoint = CGPointMake(point.x-2, point.y);
            [path addArcWithCenter:currentPoint radius:2 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        }
        else{
            [path addArcWithCenter:point radius:2 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
        }
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor whiteColor].CGColor;
        layer.strokeColor = [UIColor blueColor].CGColor;
        layer.borderWidth = 1;
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        [self.shapeArr addObject:layer];
        
    }
    
    //
    //    //5.添加目标值文字
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




-(void)setSpace_x:(float)space_x{
    _space_x = space_x;
//    NSLog(@"*******%f",space_x);

    //移除之前加载的CAShapeLayer
    for (NSInteger i = 0; i<self.shapeArr.count; i++) {
        CAShapeLayer *shape = self.shapeArr[i];
        [shape removeFromSuperlayer];
    }
    
    //移除之前加载的UILable
    NSLog(@"删除前%lu",(unsigned long)self.subviews.count);
    NSArray *arr=self.subviews;
    for (int i=0; i<arr.count; i++) {
        if ([arr[i] isKindOfClass:[UILabel class]]) {
            UILabel *lab = arr[i];
            NSLog(@"删除了第%d个%@",i,lab);
            [lab removeFromSuperview];
        }
    }
    NSLog(@"删除后%lu",(unsigned long)self.subviews.count);
    
    [self drawLineSpace_x:space_x];
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
