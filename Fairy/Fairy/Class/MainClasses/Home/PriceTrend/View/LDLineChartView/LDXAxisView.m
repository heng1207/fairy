//
//  XAxisView.m
//  WSLineChart
//
//  Created by iMac on 16/11/17.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "LDXAxisView.h"

#define topMargin 50   // 为顶部留出的空白
#define kChartLineColor         [UIColor grayColor]
#define kChartTextColor         [UIColor blackColor]
//#define defaultSpace 5
#define leftMargin 45
#define kScreenWidth [UIScreen mainScreen].bounds.size.width


@interface LDXAxisView ()

@property (strong, nonatomic) NSArray *xTitleArray;
@property (strong, nonatomic) NSArray *yValueArray;
@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;


@property (strong, nonatomic) NSArray *yValueArrayUnder;
@property (assign, nonatomic) CGFloat yMaxUnder;
@property (assign, nonatomic) CGFloat yMinUnder;


@property (assign, nonatomic) CGFloat defaultSpace;

/**
 *  记录坐标轴的第一个frame
 */
@property (assign, nonatomic) CGRect firstFrame;
@property (assign, nonatomic) CGRect firstStrFrame;//第一个点的文字的frame

@property (assign, nonatomic) CGFloat topViewHeight;
@property (assign, nonatomic) CGFloat bottomViewHeight;
@end



@implementation LDXAxisView

- (id)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray yMax:(CGFloat)yMax yMin:(CGFloat)yMin PointGap:(CGFloat)pointGap{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.xTitleArray = xTitleArray;
        self.yValueArray = yValueArray;
        self.yMax = yMax;
        self.yMin = yMin;
        
        self.pointGap = pointGap;
        
    
        self.topViewHeight = self.frame.size.height * 0.6;
        self.bottomViewHeight = self.frame.size.height * 0.4;
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame xTitleArray:(NSArray *)xTitleArray yValueArray:(NSArray *)yValueArray yMax:(CGFloat)yMax yMin:(CGFloat)yMin PointGap:(CGFloat)pointGap yValueArrayUnder:(NSArray *)yValueArrayUnder yMaxUnder:(CGFloat)yMaxUnder yMinUnder:(CGFloat)yMinUnder{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.xTitleArray = xTitleArray;
        self.yValueArray = yValueArray;
        self.yMax = yMax;
        self.yMin = yMin;
        
        self.pointGap = pointGap;
        
        self.yValueArrayUnder = yValueArrayUnder;
        self.yMaxUnder = yMaxUnder;
        self.yMinUnder = yMinUnder;
        
        self.topViewHeight = self.frame.size.height * 0.6;
        self.bottomViewHeight = self.frame.size.height * 0.4;
    
    }
    
    return self;
}


- (void)setPointGap:(CGFloat)pointGap {
    _pointGap = pointGap;
    
    [self setNeedsDisplay];
}

- (void)setIsLongPress:(BOOL)isLongPress {
    _isLongPress = isLongPress;
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self drawTopView];
    [self drawBottomView];
    [self longPress];
    
}

-(void)drawTopView{
    CGContextRef context = UIGraphicsGetCurrentContext();

    
//    //////////////// 画原点上的x轴 ///////////////////////
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
    CGSize textSize = [@"x" sizeWithAttributes:attribute];
    [self drawLine:context
        startPoint:CGPointMake(0, self.topViewHeight - textSize.height - 5)
          endPoint:CGPointMake(self.frame.size.width, self.topViewHeight - textSize.height - 5)
         lineColor:kChartLineColor
         lineWidth:1];
    
    //////////////// 画横向分割线 ///////////////////////
    CGFloat separateMargin = (self.topViewHeight - topMargin - textSize.height - 5 - 5 * 1) / 5;
    for (int i = 0; i < 5; i++) {
        
        [self drawLine:context
            startPoint:CGPointMake(0, self.topViewHeight - textSize.height - 5  - (i + 1) *(separateMargin + 1))
              endPoint:CGPointMake(0+self.frame.size.width, self.topViewHeight - textSize.height - 5  - (i + 1) *(separateMargin + 1))
             lineColor:[UIColor grayColor]
             lineWidth:.1];
    }
    
    
    /////////// 根据数据源画折线 //////////
    if (self.yValueArray && self.yValueArray.count > 0) {
        
        //画折线
        for (NSInteger i = 0; i < self.yValueArray.count; i++) {
            
            //如果是最后一个点
            if (i == self.yValueArray.count-1) {
                
                NSNumber *endValue = self.yValueArray[i];
                CGFloat chartHeight = self.topViewHeight - textSize.height - 5 - topMargin;
                //                CGPoint endPoint = CGPointMake((i+1)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                CGPoint endPoint = CGPointMake( i*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                
                
                //画最后一个点
                UIColor*aColor = [UIColor lightGrayColor]; //点的颜色
                CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
                CGContextAddArc(context, endPoint.x, endPoint.y, 1, 0, 2*M_PI, 0); //添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充
                
            }else { //不是最后一个点
                
                NSNumber *startValue = self.yValueArray[i];
                NSNumber *endValue = self.yValueArray[i+1];
                CGFloat chartHeight = self.topViewHeight - textSize.height - 5 - topMargin;
                
                //                CGPoint startPoint = CGPointMake((i+1)*self.pointGap, chartHeight -  (startValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                //                CGPoint endPoint = CGPointMake((i+2)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                
                CGPoint startPoint = CGPointMake( i*self.pointGap, chartHeight -  (startValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                CGPoint endPoint = CGPointMake((i+1)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                
                CGFloat normal[1]={1};
                CGContextSetLineDash(context,0,normal,0); //画实线
                
                //绘制数据（折线）
                [self drawLine:context startPoint:startPoint endPoint:endPoint lineColor:[UIColor colorWithRed:26/255.0 green:135/255.0 blue:254/255.0 alpha:1] lineWidth:1];
                
                
                //画点
                UIColor*aColor = [UIColor lightGrayColor]; //点的颜色
                CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
                CGContextAddArc(context, startPoint.x, startPoint.y, 1, 0, 2*M_PI, 0); //添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充
                

            }
            
            
        }
    }
    
    
    //////  根据数据源画折线与X轴之间的填充色  ///////
//    [self drawCurveLine:self.yValueArray];
    
}


-(void)drawBottomView{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    ////////////////////// X轴文字 //////////////////////////
    // 添加坐标轴Label
    for (int i = 0; i < self.xTitleArray.count; i++) {
        NSString *title = self.xTitleArray[i];
        
        [[UIColor blackColor] set];
        NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
        CGSize labelSize = [title sizeWithAttributes:attr];
        
        //        CGRect titleRect = CGRectMake((i + 1) * self.pointGap - labelSize.width / 2,self.frame.size.height - labelSize.height,labelSize.width,labelSize.height);
        CGRect titleRect = CGRectMake(i * self.pointGap ,self.frame.size.height - labelSize.height,labelSize.width,labelSize.height);
        
        if (i == 0) {
            self.firstFrame = titleRect;
            if (titleRect.origin.x < 0) {
                titleRect.origin.x = 0;
            }
            
            [title drawInRect:titleRect withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor}];
            
            //画垂直X轴的竖线
            
            //            [self drawLine:context
            //                startPoint:CGPointMake(titleRect.origin.x+labelSize.width/2, self.frame.size.height - labelSize.height-5)
            //                  endPoint:CGPointMake(titleRect.origin.x+labelSize.width/2, self.frame.size.height - labelSize.height-10)
            //                 lineColor:kChartLineColor
            //                 lineWidth:1];
            [self drawLine:context
                startPoint:CGPointMake(titleRect.origin.x, self.frame.size.height - labelSize.height-5)
                  endPoint:CGPointMake(titleRect.origin.x, self.frame.size.height - labelSize.height-10)
                 lineColor:kChartLineColor
                 lineWidth:1];
        }
        
        
        // 如果Label的文字有重叠，那么不绘制
        CGFloat maxX = CGRectGetMaxX(self.firstFrame);
        if (i != 0) {
            if ((maxX + 3) > titleRect.origin.x) {
                //不绘制
                
            }else{
                
                [title drawInRect:titleRect withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:8],NSForegroundColorAttributeName:kChartTextColor}];
                
                //画垂直X轴的竖线
                
                //                [self drawLine:context
                //                    startPoint:CGPointMake(titleRect.origin.x+labelSize.width/2, self.frame.size.height - labelSize.height-5)
                //                      endPoint:CGPointMake(titleRect.origin.x+labelSize.width/2, self.frame.size.height - labelSize.height-10)
                //                     lineColor:kChartLineColor
                //                     lineWidth:1];
                
                [self drawLine:context
                    startPoint:CGPointMake(titleRect.origin.x, self.frame.size.height - labelSize.height-5)
                      endPoint:CGPointMake(titleRect.origin.x, self.frame.size.height - labelSize.height-10)
                     lineColor:kChartLineColor
                     lineWidth:1];
                
                self.firstFrame = titleRect;
            }
        }else {
            if (self.firstFrame.origin.x < 0) {
                
                CGRect frame = self.firstFrame;
                frame.origin.x = 0;
                self.firstFrame = frame;
            }
        }
        
    }
    
    //////////////// 画原点上的x轴 ///////////////////////
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
    CGSize textSize = [@"x" sizeWithAttributes:attribute];
    
    [self drawLine:context
        startPoint:CGPointMake(0, self.frame.size.height - textSize.height - 5)
          endPoint:CGPointMake(self.frame.size.width, self.frame.size.height - textSize.height - 5)
         lineColor:kChartLineColor
         lineWidth:1];
    
    
    //////////////// 画横向分割线 ///////////////////////
    CGFloat separateMargin = (self.bottomViewHeight - topMargin - textSize.height - 5 - 5 * 1) / 5;
    for (int i = 0; i < 5; i++) {
        
        [self drawLine:context
            startPoint:CGPointMake(0, self.frame.size.height - textSize.height - 5  - (i + 1) *(separateMargin + 1))
              endPoint:CGPointMake(0+self.frame.size.width, self.frame.size.height - textSize.height - 5  - (i + 1) *(separateMargin + 1))
             lineColor:[UIColor grayColor]
             lineWidth:.1];
    }
    
    
    /////////// 根据数据源画折线 //////////
    if (self.yValueArrayUnder && self.yValueArrayUnder.count > 0) {
        
        //画折线
        for (NSInteger i = 0; i < self.yValueArrayUnder.count; i++) {
            
            //如果是最后一个点
            if (i == self.yValueArrayUnder.count-1) {
                
                NSNumber *endValue = self.yValueArrayUnder[i];
                CGFloat chartHeight = self.bottomViewHeight - textSize.height - 5 - topMargin;
                //                CGPoint endPoint = CGPointMake((i+1)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                CGPoint endPoint = CGPointMake( i*self.pointGap, chartHeight -  (endValue.floatValue-self.yMinUnder)/(self.yMaxUnder-self.yMinUnder) * chartHeight+topMargin + self.topViewHeight);
                
                
                //画最后一个点
                UIColor*aColor = [UIColor lightGrayColor]; //点的颜色
                CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
                CGContextAddArc(context, endPoint.x, endPoint.y, 1, 0, 2*M_PI, 0); //添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充
                
            }else { //不是最后一个点
                
                NSNumber *startValue = self.yValueArrayUnder[i];
                NSNumber *endValue = self.yValueArrayUnder[i+1];
                CGFloat chartHeight = self.bottomViewHeight - textSize.height - 5 - topMargin;
                
                //                CGPoint startPoint = CGPointMake((i+1)*self.pointGap, chartHeight -  (startValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                //                CGPoint endPoint = CGPointMake((i+2)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                
                CGPoint startPoint = CGPointMake( i*self.pointGap, chartHeight -  (startValue.floatValue-self.yMinUnder)/(self.yMaxUnder-self.yMinUnder) * chartHeight+topMargin + self.topViewHeight);
                CGPoint endPoint = CGPointMake((i+1)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMinUnder)/(self.yMaxUnder-self.yMinUnder) * chartHeight+topMargin + self.topViewHeight );
                
                CGFloat normal[1]={1};
                CGContextSetLineDash(context,0,normal,0); //画实线
                
                //绘制数据（折线）
                [self drawLine:context startPoint:startPoint endPoint:endPoint lineColor:[UIColor redColor] lineWidth:1];
                
                
                //画点
                UIColor*aColor = [UIColor lightGrayColor]; //点的颜色
                CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
                CGContextAddArc(context, startPoint.x, startPoint.y, 1, 0, 2*M_PI, 0); //添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充
                
            }
            
            
        }
    }
    

    
}

-(void)longPress{
    //长按时进入
    if(self.isLongPress)
    {
        
        NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
        CGSize textSize = [@"x" sizeWithAttributes:attribute];
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        NSLog(@"%f",_currentLoc.x/self.pointGap);
        int nowPoint = _currentLoc.x/self.pointGap;
        if(nowPoint >= 0 && nowPoint < [self.yValueArray count]) {
            
            NSNumber *num = [self.yValueArray objectAtIndex:nowPoint];
            CGFloat chartHeight = self.topViewHeight - textSize.height - 5 - topMargin;
            
            //            CGPoint selectPoint = CGPointMake((nowPoint+1)*self.pointGap, chartHeight -  (num.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
            CGPoint selectPoint = CGPointMake( nowPoint*self.pointGap, chartHeight -  (num.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
            
            
        
            NSDictionary *timeAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
            CGSize timeSize = [[NSString stringWithFormat:@"时间:%@",self.xTitleArray[nowPoint]] sizeWithAttributes:timeAttr];
            
            
            //画文字所在的位置  动态变化
            CGPoint drawPoint = CGPointZero;
            if(_screenLoc.x >((kScreenWidth-leftMargin)/2) && _screenLoc.y < 80) {
                //如果按住的位置在屏幕靠右边边并且在屏幕靠上面的地方   那么字就显示在按住位置的左上角40 60位置
                drawPoint = CGPointMake(_currentLoc.x-40-timeSize.width, 80-60);
            }
            else if(_screenLoc.x >((kScreenWidth-leftMargin)/2) && _screenLoc.y > self.topViewHeight-20) {
                drawPoint = CGPointMake(_currentLoc.x-40-timeSize.width, self.topViewHeight-20 -60);
            }
            else if(_screenLoc.x >((kScreenWidth-leftMargin)/2)) {
                //如果按住的位置在屏幕靠右边边   那么字就显示在按住位置的左上角40 60位置
                drawPoint = CGPointMake(_currentLoc.x-40-timeSize.width, _currentLoc.y-60);
            }
            else if (_screenLoc.x <= ((kScreenWidth-leftMargin)/2) && _screenLoc.y < 80) {
                //如果按住的位置在屏幕靠左边边并且在屏幕靠上面的地方   那么字就显示在按住位置的右上角上角40 40位置
                drawPoint = CGPointMake(_currentLoc.x+40, 80-60);
                
            }
            else if (_screenLoc.x <= ((kScreenWidth-leftMargin)/2) && _screenLoc.y > self.topViewHeight-20) {
                
                drawPoint = CGPointMake(_currentLoc.x+40, self.topViewHeight-20 -60);
                
            }
            else if(_screenLoc.x  <= ((kScreenWidth-leftMargin)/2)) {
                //如果按住的位置在屏幕靠左边   那么字就显示在按住位置的右上角40 60位置
                drawPoint = CGPointMake(_currentLoc.x+40, _currentLoc.y-60);
            }
            
            
//            //画选中的数值
//            [[NSString stringWithFormat:@"时间:%@",self.xTitleArray[nowPoint]] drawAtPoint:CGPointMake(drawPoint.x, drawPoint.y) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor]}];
            
            
            // 判断是不是小数
            if ([self isPureFloat:[num floatValue]]) {
                [[NSString stringWithFormat:@"价格:%.2fm", [num floatValue]] drawAtPoint:CGPointMake(drawPoint.x, drawPoint.y+15) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor greenColor]}];
            }
            else {
                [[NSString stringWithFormat:@"价格:%.0fm", [num floatValue]] drawAtPoint:CGPointMake(drawPoint.x, drawPoint.y+15)withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor greenColor]}];
                
            }
            
            
            //画十字线
            [self drawLine:context startPoint:CGPointMake(selectPoint.x, 0) endPoint:CGPointMake(selectPoint.x, self.frame.size.height- textSize.height - 5) lineColor:[UIColor lightGrayColor] lineWidth:1];
             [self drawLine:context startPoint:CGPointMake(0, selectPoint.y) endPoint:CGPointMake(self.frame.size.width, selectPoint.y) lineColor:[UIColor lightGrayColor] lineWidth:1];
            
            
            // 交界点
            CGRect myOval = {selectPoint.x-2, selectPoint.y-2, 4, 4};
            CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
            CGContextAddEllipseInRect(context, myOval);
            CGContextFillPath(context);
        }
        
        
        
        
        //画下面的十字线
        if(nowPoint >= 0 && nowPoint < [self.yValueArrayUnder count]) {
            
            NSNumber *num = [self.yValueArrayUnder objectAtIndex:nowPoint];
            CGFloat chartHeight = self.bottomViewHeight - textSize.height - 5 - topMargin;
            
            //            CGPoint selectPoint = CGPointMake((nowPoint+1)*self.pointGap, chartHeight -  (num.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
            CGPoint selectPoint = CGPointMake( nowPoint*self.pointGap, chartHeight -  (num.floatValue-self.yMinUnder)/(self.yMaxUnder-self.yMinUnder) * chartHeight+topMargin + self.topViewHeight);
            
            
            
            NSDictionary *timeAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
            CGSize timeSize = [[NSString stringWithFormat:@"时间:%@",self.xTitleArray[nowPoint]] sizeWithAttributes:timeAttr];
            
            
            //画文字所在的位置  动态变化
            //时间
            float orightX;
            if ( (selectPoint.x - timeSize.width) < 0) {
                orightX =0;
            }else if ( (selectPoint.x + timeSize.width) > self.frame.size.width){
                orightX = self.frame.size.width -timeSize.width;
            }else{
                orightX = selectPoint.x -timeSize.width/2;
            }
            
            CGPoint timePoint = CGPointMake(orightX, self.frame.size.height-timeSize.height);
            
            //画选中的数值
            [[NSString stringWithFormat:@"时间:%@",self.xTitleArray[nowPoint]] drawAtPoint:CGPointMake(timePoint.x, timePoint.y) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor]}];
            
            
            
            CGPoint drawPoint = CGPointZero;
            if(_screenLoc.x >((kScreenWidth-leftMargin)/2) && _screenLoc.y < 80) {
                //如果按住的位置在屏幕靠右边边并且在屏幕靠上面的地方   那么字就显示在按住位置的左上角40 60位置
                drawPoint = CGPointMake(_currentLoc.x-40-timeSize.width, 80-60 + self.topViewHeight);
            }
            else if(_screenLoc.x >((kScreenWidth-leftMargin)/2) && _screenLoc.y > self.frame.size.height-self.bottomViewHeight) {
                //如果按住的位置在屏幕靠右边边并且在屏幕靠下面的地方   那么字就显示在按住位置的左上角40 60位置
                drawPoint = CGPointMake(_currentLoc.x-40-timeSize.width, self.frame.size.height-self.bottomViewHeight);
            }
            else if(_screenLoc.x >((kScreenWidth-leftMargin)/2)) {
                //如果按住的位置在屏幕靠右边边   那么字就显示在按住位置的左上角40 60位置
                drawPoint = CGPointMake(_currentLoc.x-40-timeSize.width, _currentLoc.y-60 + self.bottomViewHeight);
            }
            else if (_screenLoc.x <= ((kScreenWidth-leftMargin)/2) && _screenLoc.y < 80) {
                //如果按住的位置在屏幕靠左边边并且在屏幕靠上面的地方   那么字就显示在按住位置的右上角上角40 40位置
                drawPoint = CGPointMake(_currentLoc.x+40, 80-60 + self.topViewHeight);
                
            }
            else if (_screenLoc.x <= ((kScreenWidth-leftMargin)/2) && _screenLoc.y > self.frame.size.height-self.bottomViewHeight) {
                
                drawPoint = CGPointMake(_currentLoc.x+40, self.frame.size.height-self.bottomViewHeight);
                
            }
            else if(_screenLoc.x  <= ((kScreenWidth-leftMargin)/2)) {
                //如果按住的位置在屏幕靠左边   那么字就显示在按住位置的右上角40 60位置
                drawPoint = CGPointMake(_currentLoc.x+40, _currentLoc.y-60 + self.bottomViewHeight);
            }

            
            
            // 判断是不是小数
            if ([self isPureFloat:[num floatValue]]) {
                [[NSString stringWithFormat:@"量:%.2fm", [num floatValue]] drawAtPoint:CGPointMake(drawPoint.x, drawPoint.y+15) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor greenColor]}];
            }
            else {
                [[NSString stringWithFormat:@"量:%.0fm", [num floatValue]] drawAtPoint:CGPointMake(drawPoint.x, drawPoint.y+15)withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor greenColor]}];

            }
            
            
            //画十字线
            [self drawLine:context startPoint:CGPointMake(selectPoint.x, 0) endPoint:CGPointMake(selectPoint.x, self.frame.size.height- textSize.height - 5) lineColor:[UIColor lightGrayColor] lineWidth:1];
            [self drawLine:context startPoint:CGPointMake(0, selectPoint.y) endPoint:CGPointMake(self.frame.size.width, selectPoint.y) lineColor:[UIColor lightGrayColor] lineWidth:1];
            
            
            // 交界点
            CGRect myOval = {selectPoint.x-2, selectPoint.y-2, 4, 4};
            CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
            CGContextAddEllipseInRect(context, myOval);
            CGContextFillPath(context);
            
            
            
            
            
        }

    }
    
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


// 判断是小数还是整数
- (BOOL)isPureFloat:(CGFloat)num {
    int i = num;
    
    CGFloat result = num - i;
    
    // 当不等于0时，是小数
    return result != 0;
}

//填充曲线和X坐标之间（折线）
- (void)drawFoldLine:(NSArray *)yValueArray{

    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
    CGSize textSize = [@"x" sizeWithAttributes:attribute];


    NSNumber *startValue = self.yValueArray[0];
    CGFloat chartHeight = self.frame.size.height - textSize.height - 5 - topMargin;
    CGPoint startPoint = CGPointMake( 0, chartHeight -  (startValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);

    CGPoint endPoint;
    for (NSInteger i = 1; i < self.yValueArray.count; i++) {

        NSNumber *endValue = self.yValueArray[i];
        CGFloat chartHeight = self.frame.size.height - textSize.height - 5 - topMargin;
        endPoint = CGPointMake((i)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    }

    CGPoint XendPoint = CGPointMake((self.yValueArray.count-1)*self.pointGap, self.frame.size.height - textSize.height - 5);
    CGPoint XstartPoint = CGPointMake(0, self.frame.size.height - textSize.height - 5);

    CGContextAddLineToPoint(context, XendPoint.x, XendPoint.y);
    CGContextAddLineToPoint(context, XstartPoint.x, XstartPoint.y);
    CGContextAddLineToPoint(context, startPoint.x, startPoint.y);

    [[UIColor orangeColor] setFill];
    CGContextFillPath(context); //填充内部
    CGContextClosePath(context); //最后关闭它
}


//填充曲线和X坐标之间（曲线）
- (void)drawCurveLine:(NSArray *)yValueArray{
    
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:8]};
    CGSize textSize = [@"x" sizeWithAttributes:attribute];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*
     绘制曲线
     */
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint PrePonit;
    
    NSNumber *startValue = self.yValueArray[0];
    CGFloat chartHeight = self.topViewHeight - textSize.height - 5 - topMargin;
    
    CGPoint startPoint = CGPointMake( 0, chartHeight -  (startValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
    [path moveToPoint:startPoint];
    
    PrePonit = startPoint;

   
    for (NSInteger i = 1; i < self.yValueArray.count; i++) {
        
        NSNumber *endValue = self.yValueArray[i];

        CGPoint NowPoint = CGPointMake((i)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);

        /*绘制三次贝塞尔曲线
         c:图形上下文
         cp1x:第一个控制点x坐标
         cp1y:第一个控制点y坐标
         cp2x:第二个控制点x坐标
         cp2y:第二个控制点y坐标
         x:结束点x坐标
         y:结束点y坐标
         */
        [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((PrePonit.x+NowPoint.x)/2, PrePonit.y) controlPoint2:CGPointMake((PrePonit.x+NowPoint.x)/2, NowPoint.y)]; //三次曲线
        PrePonit = NowPoint;
        
        
    }
    
    CGPoint XendPoint = CGPointMake((self.yValueArray.count-1)*self.pointGap, self.topViewHeight - textSize.height - 5);
    CGPoint XstartPoint = CGPointMake(0, self.topViewHeight - textSize.height - 5);
    
    [path addLineToPoint:XendPoint];
    [path addLineToPoint:XstartPoint];
    [path addLineToPoint:startPoint];

    
    //把路径添加到上下文
    CGContextAddPath(context, path.CGPath);
    [[UIColor orangeColor] setFill];
    [[UIColor blueColor] setStroke];
    //绘制渐变色
    [self drawLinearGradientWithContext:context path:path.CGPath beginColor:[UIColor orangeColor].CGColor endColor:[UIColor whiteColor].CGColor];
    CGContextDrawPath(context, kCGPathFillStroke);
    
}


- (void)drawLinearGradientWithContext:(CGContextRef)context
                                 path:(CGPathRef)path
                           beginColor:(CGColorRef)beginColor
                             endColor:(CGColorRef)endColor;
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 1.0};
    NSArray *colorArr = @[(__bridge id)beginColor, (__bridge id)endColor];
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colorArr, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    //垂直渐变
    //    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    //    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    //水平渐变
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpace);
}


@end
