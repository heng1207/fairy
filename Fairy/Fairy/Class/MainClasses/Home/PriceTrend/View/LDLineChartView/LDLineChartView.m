
//
//  WSLineChartView.m
//  WSLineChart
//
//  Created by iMac on 16/11/17.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "LDLineChartView.h"
#import "SVProgressHUD.h"
#import "LDXAxisView.h"
#import "LDYAxisView.h"

#define leftMargin 45
#define minNumbers 10  //小于等于10不会缩放




@interface LDLineChartView ()

@property (strong, nonatomic) NSArray *xTitleArray;
@property (strong, nonatomic) NSArray *yValueArray;
@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;
@property (strong, nonatomic) LDYAxisView *yAxisView;
@property (strong, nonatomic) LDXAxisView *xAxisView;

@property (strong, nonatomic) NSArray *yValueArrayUnder;
@property (assign, nonatomic) CGFloat yMaxUnder;
@property (assign, nonatomic) CGFloat yMinUnder;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat pointGap;


@property (assign, nonatomic) CGFloat defaultSpace;//默认间距，根据数据多少计算
@property (assign, nonatomic) CGFloat MaxSpace;//最大间隔，当数据小于 minNumbers 时,不能捏合

@property (assign, nonatomic) CGFloat moveDistance;

@end




@implementation LDLineChartView

-(id)initWithFrame:(CGRect)frame xTitleArray:(NSArray *)xTitleArray yValueArray:(NSArray *)yValueArray yMax:(CGFloat)yMax yMin:(CGFloat)yMin yValueArrayUnder:(NSArray *)yValueArrayUnder yMaxUnder:(CGFloat)yMaxUnder yMin:(CGFloat)yMinUnder{
    
//- (id)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray yMax:(CGFloat)yMax yMin:(CGFloat)yMin {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.xTitleArray = xTitleArray;
        self.yValueArray = yValueArray;
        self.yMax = yMax;
        self.yMin = yMin;
        
        self.yValueArrayUnder = yValueArrayUnder;
        self.yMaxUnder = yMaxUnder;
        self.yMinUnder = yMinUnder;
        
        _defaultSpace = (self.frame.size.width-leftMargin)/(xTitleArray.count-1);
        _MaxSpace = (self.frame.size.width-leftMargin)/(minNumbers-1);

        
        self.pointGap = _defaultSpace;
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-leftMargin, self.frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        
        UILabel *explainLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 6, self.width-24, 12)];
        [self addSubview:explainLab];
        explainLab.text=@"*数据来源于 coinmarketcap.com";
        explainLab.textColor = [UIColor grayColor];
        explainLab.font = AdaptedFontSize(17);
        
        
        UILabel *priceUSDLab=[[UILabel alloc]initWithFrame:CGRectMake(self.centerX-32, 20, 65, 18)];
        priceUSDLab.text = @"价格 USD";
        priceUSDLab.font = AdaptedFontSize(28);
        [self addSubview:priceUSDLab];
        
        
        UILabel *volumeUSDLab=[[UILabel alloc]initWithFrame:CGRectMake(self.centerX-32, self.height*0.6+20, 65, 18)];
        volumeUSDLab.text = @"量 USD";
        volumeUSDLab.font = AdaptedFontSize(28);
        [self addSubview:volumeUSDLab];
        
        
        
        
        [self creatXAxisView];
        [self creatYAxisView];
        
        
        

        
        //捏合手势
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
        [self.xAxisView addGestureRecognizer:pinch];
        
        //长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressAction:)];
        [self.xAxisView addGestureRecognizer:longPress];
        

    }
    return self;
}



- (void)creatYAxisView {
    
//    self.yAxisView = [[YAxisView alloc]initWithFrame:CGRectMake(self.frame.size.width-leftMargin, 0, leftMargin, self.frame.size.height) yMax:self.yMax yMin:self.yMin];
    
    self.yAxisView = [[LDYAxisView alloc]initWithFrame:CGRectMake(self.frame.size.width-leftMargin, 0, leftMargin, self.frame.size.height) yMax:self.yMax yMin:self.yMin yMaxUnder:self.yMaxUnder yMinUnder:self.yMinUnder];
    
    [self addSubview:self.yAxisView];
    
}


- (void)creatXAxisView {
    
//    self.xAxisView = [[XAxisView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-leftMargin, self.frame.size.height) xTitleArray:self.xTitleArray yValueArray:self.yValueArray yMax:self.yMax yMin:self.yMin PointGap:self.pointGap];
    
    self.xAxisView = [[LDXAxisView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-leftMargin, self.frame.size.height) xTitleArray:self.xTitleArray yValueArray:self.yValueArray yMax:self.yMax yMin:self.yMin PointGap:self.pointGap yValueArrayUnder:self.yValueArrayUnder yMaxUnder:self.yMaxUnder yMinUnder:self.yMinUnder];
    
    NSLog(@"%f---%f",self.frame.size.width,self.frame.size.height);
    [_scrollView addSubview:self.xAxisView];
 
    _scrollView.contentSize = CGSizeMake(self.xAxisView.frame.size.width, 0);
    
}



// 捏合手势监听方法
- (void)pinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    
    if (self.xTitleArray.count<=minNumbers) return;
    
    
    CGFloat currentIndex,leftMagin;
    if( recognizer.numberOfTouches == 2 ) {
        //2.获取捏合中心点 -> 捏合中心点距离scrollviewcontent左侧的距离
        CGPoint p1 = [recognizer locationOfTouch:0 inView:self.xAxisView];
        CGPoint p2 = [recognizer locationOfTouch:1 inView:self.xAxisView];
        CGFloat centerX = (p1.x+p2.x)/2;
        leftMagin = centerX - self.scrollView.contentOffset.x;
        //            NSLog(@"centerX = %f",centerX);
        //            NSLog(@"self.scrollView.contentOffset.x = %f",self.scrollView.contentOffset.x);
        //            NSLog(@"leftMagin = %f",leftMagin);
        
        
        //获取捏合点对应的数据下摆
        currentIndex = centerX / self.pointGap;
        //            NSLog(@"currentIndex = %f",currentIndex);
        
        
        NSLog(@"%f",recognizer.scale);
        self.pointGap *= recognizer.scale;
        //            self.pointGap = self.pointGap > _defaultSpace ? _defaultSpace : self.pointGap;
        if (self.pointGap >= _MaxSpace) {
            
//            [SVProgressHUD showErrorWithStatus:@"已经放至最大"];
            self.pointGap = _MaxSpace;
            
        }
        else if (self.pointGap <= _defaultSpace){
//            [SVProgressHUD showErrorWithStatus:@"已经缩小到最小"];
            self.pointGap = _defaultSpace;
        }
        
        self.xAxisView.pointGap = self.pointGap;
        recognizer.scale = 1.0;
        
        self.xAxisView.frame = CGRectMake(0, 0, (self.xTitleArray.count-1) * self.pointGap, self.frame.size.height);

        
        self.scrollView.contentOffset = CGPointMake(currentIndex*self.pointGap-leftMagin, 0);
        //            NSLog(@"contentOffset = %f",self.scrollView.contentOffset.x);
    }
    
    self.scrollView.contentSize = CGSizeMake(self.xAxisView.frame.size.width, 0);
    
}


- (void)event_longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state) {
        
        CGPoint location = [longPress locationInView:self.xAxisView];
        
        //相对于屏幕的位置
        CGPoint screenLoc = CGPointMake(location.x - self.scrollView.contentOffset.x, location.y);
        [self.xAxisView setScreenLoc:screenLoc];
   
    
        if (ABS(location.x - _moveDistance) > self.pointGap) { //不能长按移动一点点就重新绘图  要让定位的点改变了再重新绘图
            
            [self.xAxisView setIsShowLabel:YES];
            [self.xAxisView setIsLongPress:YES];
            self.xAxisView.currentLoc = location;
            _moveDistance = location.x;
            

            
        }
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        _moveDistance = 0;
        //恢复scrollView的滑动
        [self.xAxisView setIsLongPress:NO];
        [self.xAxisView setIsShowLabel:NO];
        
    }
}




@end
