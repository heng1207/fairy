//
//  BezierView.m
//  BezierLine
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BezierView.h"
#import "BezierCurveView.h"
#import "TargetView.h"
#import "ClassView.h"


#define MARGIN_Top        25   //上间隔
#define MARGIN            12   // 左右间隔
#define leftMargin        24   // TargetView宽度


@interface BezierView()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) BezierCurveView *curveView;
@property (strong, nonatomic) TargetView *targetView;
@property (strong, nonatomic) NSMutableArray *xTitleArray;
@property (strong, nonatomic) NSMutableArray *yValueArray;
@property (assign, nonatomic) NSMutableArray *targetValues;



@property (assign, nonatomic) CGFloat currentSpace; //当前间隔
//间隔在 defaultSpace和MinSpace之间变化
@property (assign, nonatomic) CGFloat defaultSpace;//默认间距，根据数据多少计算，同时也为最大间隔，有7个数
@property (assign, nonatomic) CGFloat minSpace;//最小间隔，当小于该间隔时,不能继续缩小，有14个数

@end

@implementation BezierView

-(instancetype)initWithFrame:(CGRect)frame WithX_Value_Names:(NSMutableArray *)x_names Y_Value_Names:(NSMutableArray *)y_names TargetValues:(NSMutableArray *)targetValues Type:(Types)type{
    self = [super initWithFrame:frame];
    if (self) {
        
    
        self.xTitleArray = x_names;
        self.yValueArray = y_names;
        self.targetValues = targetValues;
        
        _defaultSpace = (self.frame.size.width-2*MARGIN-leftMargin)/6;
        _minSpace = (self.frame.size.width-2*MARGIN-leftMargin)/13;
        _currentSpace = _defaultSpace;
        
        ClassView *classView = [[[NSBundle mainBundle] loadNibNamed:@"ClassView" owner:self options:0] objectAtIndex:0];
        classView.frame = CGRectMake(0, 0, UIScreenW, MARGIN_Top);
        [self addSubview:classView];
    
        
        _targetView = [[TargetView alloc]initWithFrame:CGRectMake(MARGIN, MARGIN_Top, leftMargin, self.frame.size.height-MARGIN_Top) WithY_Value_Names:y_names];
        [self addSubview:_targetView];
        
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(MARGIN+leftMargin, MARGIN_Top, self.frame.size.width-2*MARGIN-leftMargin, self.frame.size.height-MARGIN_Top)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        
        
        self.curveView = [[BezierCurveView alloc]initWithFrame:CGRectMake(0, 0, (self.xTitleArray.count-1) * self.defaultSpace, self.frame.size.height-MARGIN_Top) WithX_Value_Names:self.xTitleArray Y_Value_Names:self.yValueArray TargetValues:self.targetValues LineType:LineType_quxian Space_x:self.defaultSpace];
        [_scrollView addSubview:self.curveView];
        _scrollView.contentSize = CGSizeMake(self.curveView.frame.size.width, 0);
        
        //捏合手势
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
        [self.curveView addGestureRecognizer:pinch];
        
    }
    return self;
}


// 捏合手势监听方法
- (void)pinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    
    CGFloat currentIndex = 0.0,leftMagin;
    if( recognizer.numberOfTouches == 2 ) {
        //2.获取捏合中心点 -> 捏合中心点距离scrollviewcontent左侧的距离
        CGPoint p1 = [recognizer locationOfTouch:0 inView:self.curveView];
        CGPoint p2 = [recognizer locationOfTouch:1 inView:self.curveView];
        CGFloat centerX = (p1.x+p2.x)/2;
        leftMagin = centerX - self.scrollView.contentOffset.x;
        //            NSLog(@"centerX = %f",centerX);
        //            NSLog(@"self.scrollView.contentOffset.x = %f",self.scrollView.contentOffset.x);
        //            NSLog(@"leftMagin = %f",leftMagin);
        
        
        //获取捏合点对应的数据下摆
        currentIndex = centerX / self.currentSpace;
        NSLog(@"currentIndex = %f",currentIndex);
        
        
        NSLog(@"%f",recognizer.scale);
        self.currentSpace *= recognizer.scale;

        if (self.currentSpace >= _defaultSpace) {
            
            [SVProgressHUD showErrorWithStatus:@"已经放至最大"];
            self.currentSpace = _defaultSpace;
            
        }
        else if (self.currentSpace <= _minSpace){
            [SVProgressHUD showErrorWithStatus:@"已经缩小到最小"];
            self.currentSpace = _minSpace;
        }
        
        self.curveView.space_x = self.currentSpace;
        recognizer.scale = 1.0;
        
        self.curveView.frame = CGRectMake(0, 0, (self.xTitleArray.count-1) * self.currentSpace, self.frame.size.height-MARGIN_Top);
        
        self.scrollView.contentOffset = CGPointMake(currentIndex*self.currentSpace-leftMagin, 0);
        //            NSLog(@"contentOffset = %f",self.scrollView.contentOffset.x);
    }
    
    self.scrollView.contentSize = CGSizeMake(self.curveView.frame.size.width, 0);
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
