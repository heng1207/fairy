//
//  Y_KLineView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineView.h"
#import "Y_KLineMainView.h"
#import "Y_KLineMAView.h"
#import "Y_VolumeMAView.h"
#import "Y_AccessoryMAView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"

#import "Y_StockChartGlobalVariable.h"
#import "Y_KLineVolumeView.h"
#import "Y_StockChartRightYView.h"
#import "Y_KLineAccessoryView.h"
@interface Y_KLineView() <UIScrollViewDelegate, Y_KLineMainViewDelegate, Y_KLineVolumeViewDelegate, Y_KLineAccessoryViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

/*********主视图********/
/**
 *  主K线图
 */
@property (nonatomic, strong) Y_KLineMainView *kLineMainView;

/**
 *  成交量图
 */
@property (nonatomic, strong) Y_KLineVolumeView *kLineVolumeView;

/**
 *  副图
 */
//@property (nonatomic, strong) Y_KLineAccessoryView *kLineAccessoryView;


/*********右边辅助视图********/
/**
 *  右侧价格图
 */
@property (nonatomic, strong) Y_StockChartRightYView *priceView;

/**
 *  右侧成交量图
 */
@property (nonatomic, strong) Y_StockChartRightYView *volumeView;

/**
 *  右侧Accessory图
 */
//@property (nonatomic, strong) Y_StockChartRightYView *accessoryView;



/**
 *  旧的scrollview准确位移
 */
@property (nonatomic, assign) CGFloat oldExactOffset;



/*********MA视图********/
/**
 *  kLine-MAView    开收盘价
 */
@property (nonatomic, strong) Y_KLineMAView *kLineMAView;

/**
 *  Volume-MAView 交易量
 */
@property (nonatomic, strong) Y_VolumeMAView *volumeMAView;

/**
 *  Accessory-MAView
 */
//@property (nonatomic, strong) Y_AccessoryMAView *accessoryMAView;



/**
 *  长按后显示的View
 */
@property (nonatomic, strong) UIView *verticalView;

/**
 *  当前可见K线的第一根K线对应时间
 */
@property(nonatomic,strong) UILabel *startTimeLab;

/**
 *  当前时间
 */
@property(nonatomic,strong) UILabel *currentTimeLab;



@property (nonatomic, strong) MASConstraint *kLineMainViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *kLineVolumeViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *priceViewHeightConstraint;

@property (nonatomic, strong) MASConstraint *volumeViewHeightConstraint;

@end

@implementation Y_KLineView

//initWithFrame设置视图比例
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.mainViewRatio = [Y_StockChartGlobalVariable kLineMainViewRadio];
        self.volumeViewRatio = [Y_StockChartGlobalVariable kLineVolumeViewRadio];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor =[UIColor colorWithHex:@"#eeeeee"];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
//        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        
        //缩放手势
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(event_pichMethod:)];
        [_scrollView addGestureRecognizer:pinchGesture];
        
        //长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressMethod:)];
        [_scrollView addGestureRecognizer:longPressGesture];
        
        [self addSubview:_scrollView];
        
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self).offset(-48);
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        [self layoutIfNeeded];
    }
    return _scrollView;
}


- (Y_KLineMainView *)kLineMainView
{
    if (!_kLineMainView && self) {
        _kLineMainView = [Y_KLineMainView new];
        _kLineMainView.delegate = self;
        [self.scrollView addSubview:_kLineMainView];
        [_kLineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView).offset(25);
            make.left.equalTo(self.scrollView);
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy(self.mainViewRatio);
            make.width.equalTo(@0);
        }];
        
    }
    //加载rightYYView
    self.priceView.backgroundColor = [UIColor clearColor];
    self.volumeView.backgroundColor = [UIColor clearColor];
//    self.accessoryView.backgroundColor = [UIColor clearColor];
    return _kLineMainView;
}

- (Y_KLineVolumeView *)kLineVolumeView
{
    if(!_kLineVolumeView && self)
    {
        _kLineVolumeView = [Y_KLineVolumeView new];
        _kLineVolumeView.delegate = self;
        [self.scrollView addSubview:_kLineVolumeView];
        [_kLineVolumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.kLineMainView);
            make.top.equalTo(self.kLineMainView.mas_bottom).offset(10);
            make.width.equalTo(self.kLineMainView.mas_width);
            self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy(self.volumeViewRatio);
        }];
        [self layoutIfNeeded];
    }
    return _kLineVolumeView;
}

//- (Y_KLineAccessoryView *)kLineAccessoryView
//{
//    if(!_kLineAccessoryView && self)
//    {
//        _kLineAccessoryView = [Y_KLineAccessoryView new];
//        _kLineAccessoryView.delegate = self;
//        [self.scrollView addSubview:_kLineAccessoryView];
//        [_kLineAccessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.kLineVolumeView);
//            make.top.equalTo(self.kLineVolumeView.mas_bottom).offset(10);
//            make.width.equalTo(self.kLineVolumeView.mas_width);
////            make.height.equalTo(1);
//            make.height.mas_equalTo(1);
////            make.height.equalTo(self.scrollView.mas_height).multipliedBy(0.2);
//        }];
//        [self layoutIfNeeded];
//    }
//    return _kLineAccessoryView;
//}

- (Y_StockChartRightYView *)priceView
{
    if(!_priceView)
    {
        _priceView = [Y_StockChartRightYView new];
        [self insertSubview:_priceView aboveSubview:self.scrollView];
        [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(25);
            make.right.equalTo(self.mas_right);
            make.width.equalTo(@(Y_StockChartKLinePriceViewWidth));
            make.bottom.equalTo(self.kLineMainView.mas_bottom).offset(-15);
        }];
    }
    return _priceView;
}

- (Y_StockChartRightYView *)volumeView
{
    if(!_volumeView)
    {
        _volumeView = [Y_StockChartRightYView new];
        [self insertSubview:_volumeView aboveSubview:self.scrollView];//_volumeView添加在self.scrollView上面
        [_volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kLineVolumeView.mas_top).offset(10);
            make.right.width.equalTo(self.priceView);
//            make.height.equalTo(self).multipliedBy(self.volumeViewRatio);
            make.bottom.equalTo(self.kLineVolumeView);
        }];
    }
    return _volumeView;
}

//- (Y_StockChartRightYView *)accessoryView
//{
//    if(!_accessoryView)
//    {
//        _accessoryView = [Y_StockChartRightYView new];
//        [self insertSubview:_accessoryView aboveSubview:self.scrollView];
//        [_accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.kLineAccessoryView.mas_top).offset(10);
//            make.right.width.equalTo(self.volumeView);
//            make.height.equalTo(self.kLineAccessoryView.mas_height);
//        }];
//    }
//    return _accessoryView;
//}



- (Y_KLineMAView *)kLineMAView
{
    if (!_kLineMAView) {
        _kLineMAView = [Y_KLineMAView view];
        [self addSubview:_kLineMAView];
        [_kLineMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self).offset(5);
            //            make.height.equalTo(@10);
            make.height.equalTo(@20);
            
        }];
    }
    return _kLineMAView;
}

- (Y_VolumeMAView *)volumeMAView
{
    if (!_volumeMAView) {
        _volumeMAView = [Y_VolumeMAView view];
        [self addSubview:_volumeMAView];
        [_volumeMAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self.kLineVolumeView.mas_top);
            make.height.equalTo(@10);
        }];
    }
    return _volumeMAView;
}

//- (Y_AccessoryMAView *)accessoryMAView
//{
//    if(!_accessoryMAView) {
//        _accessoryMAView = [Y_AccessoryMAView new];
//        [self addSubview:_accessoryMAView];
//        [_accessoryMAView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self);
//            make.left.equalTo(self);
//            make.top.equalTo(self.kLineAccessoryView.mas_top);
//            make.height.equalTo(@10);
//        }];
//    }
//    return _accessoryMAView;
//}

-(UILabel *)startTimeLab{
    if (!_startTimeLab) {
        _startTimeLab = [UILabel new];
        _startTimeLab.font = [UIFont systemFontOfSize:10];
        _startTimeLab.textColor = [UIColor assistTextColor];
        [self addSubview:_startTimeLab];
        
        [_startTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self.kLineVolumeView.mas_bottom).offset(5);
            make.height.equalTo(@10);
            make.width.equalTo(@100);
        }];
        
        
    }
    return _startTimeLab;
}

-(UILabel *)currentTimeLab{
    if (!_currentTimeLab) {
        _currentTimeLab = [UILabel new];
        _currentTimeLab.font = [UIFont systemFontOfSize:10];
        _currentTimeLab.textColor = [UIColor assistTextColor];
        [self addSubview:_currentTimeLab];
        
        [_currentTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.volumeView.mas_left);
            make.top.equalTo(self.kLineVolumeView.mas_bottom).offset(5);
            make.height.equalTo(@10);
            make.width.equalTo(@100);
        }];
    }
    return _currentTimeLab;
}


#pragma mark - set方法

#pragma mark kLineModels设置方法
- (void)setKLineModels:(NSArray *)kLineModels
{
    if(!kLineModels) {
        return;
    }
    _kLineModels = kLineModels;
    [self private_drawKLineMainView];
    //设置contentOffset
    CGFloat kLineViewWidth = self.kLineModels.count * [Y_StockChartGlobalVariable kLineWidth] + (self.kLineModels.count + 1) * [Y_StockChartGlobalVariable kLineGap] + 10;
    CGFloat offset = kLineViewWidth - self.scrollView.frame.size.width;
    if (offset > 0)
    {
        self.scrollView.contentOffset = CGPointMake(offset, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    Y_KLineModel *model = [kLineModels lastObject];
    [self.kLineMAView maProfileWithModel:model];
    [self.volumeMAView maProfileWithModel:model];
//    self.accessoryMAView.targetLineStatus = self.targetLineStatus;
//    [self.accessoryMAView maProfileWithModel:model];
}
- (void)setTargetLineStatus:(Y_StockChartTargetLineStatus)targetLineStatus
{
    _targetLineStatus = targetLineStatus;
    if(targetLineStatus < 103)
    {
        if(targetLineStatus == Y_StockChartTargetLineStatusAccessoryClose){
            
            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.60];
            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.27];

        } else {
            [Y_StockChartGlobalVariable setkLineMainViewRadio:0.5];
            [Y_StockChartGlobalVariable setkLineVolumeViewRadio:0.2];

        }
        
        [self.kLineMainViewHeightConstraint uninstall];
        [_kLineMainView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.kLineMainViewHeightConstraint = make.height.equalTo(self.scrollView).multipliedBy([Y_StockChartGlobalVariable kLineMainViewRadio]);
        }];
        [self.kLineVolumeViewHeightConstraint uninstall];
        [self.kLineVolumeView mas_updateConstraints:^(MASConstraintMaker *make) {
            self.kLineVolumeViewHeightConstraint = make.height.equalTo(self.scrollView.mas_height).multipliedBy([Y_StockChartGlobalVariable kLineVolumeViewRadio]);
        }];
        [self reDraw];
    }

}
#pragma mark - event事件处理方法
#pragma mark 缩放执行方法
- (void)event_pichMethod:(UIPinchGestureRecognizer *)pinch
{
    static CGFloat oldScale = 1.0f;
    CGFloat difValue = pinch.scale - oldScale;
    if(ABS(difValue) > Y_StockChartScaleBound) {
        CGFloat oldKLineWidth = [Y_StockChartGlobalVariable kLineWidth];

        NSInteger oldNeedDrawStartIndex = self.kLineMainView.needDrawStartIndex;
        NSLog(@"原来的index%ld",self.kLineMainView.needDrawStartIndex);
        [Y_StockChartGlobalVariable setkLineWith:oldKLineWidth * (difValue > 0 ? (1 + Y_StockChartScaleFactor) : (1 - Y_StockChartScaleFactor))];
        oldScale = pinch.scale;
        
        //更新MainView的宽度
        [self.kLineMainView updateMainViewWidth];
        
        if( pinch.numberOfTouches == 2 ) {
            CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
            CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
            CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
            NSUInteger oldLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + oldKLineWidth);
            NSUInteger newLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [Y_StockChartGlobalVariable kLineGap]) / ([Y_StockChartGlobalVariable kLineGap] + [Y_StockChartGlobalVariable kLineWidth]);
            
            self.kLineMainView.pinchStartIndex = oldNeedDrawStartIndex + oldLeftArrCount - newLeftArrCount;
            //            self.kLineMainView.pinchPoint = centerPoint;
            NSLog(@"计算得出的index%lu",self.kLineMainView.pinchStartIndex);
        }
        [self.kLineMainView drawMainView];
    }
}
#pragma mark 长按手势执行方法
- (void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    static CGFloat oldPositionX = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state)
    {
        CGPoint location = [longPress locationInView:self.scrollView];
        NSLog(@"%f****%f",location.x,location.y);
        //ABS函数返回一个数的绝对值
        if(ABS(oldPositionX - location.x) < ([Y_StockChartGlobalVariable kLineWidth] + [Y_StockChartGlobalVariable kLineGap])/2)
        {
            return;
        }
        
        //暂停滑动
        self.scrollView.scrollEnabled = NO;
        oldPositionX = location.x;
        
        //初始化竖线
        if(!self.verticalView)
        {
            self.verticalView = [UIView new];
            self.verticalView.clipsToBounds = YES;
            [self.scrollView addSubview:self.verticalView];
            self.verticalView.backgroundColor = [UIColor longPressLineColor];
            [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(25);
                make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
                make.height.equalTo(self.scrollView.mas_height);
                make.left.equalTo(@(-10));
            }];
        }
        
        //更新竖线位置
        CGFloat rightXPosition = [self.kLineMainView getExactXPositionWithOriginXPosition:location.x];
        [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(rightXPosition));
        }];
        [self.verticalView layoutIfNeeded];
        self.verticalView.hidden = NO;
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        //取消竖线
        if(self.verticalView)
        {
            self.verticalView.hidden = YES;
        }
        oldPositionX = 0;
        //恢复scrollView的滑动
        self.scrollView.scrollEnabled = YES;
        
        Y_KLineModel *lastModel = self.kLineModels.lastObject;
        [self.kLineMAView maProfileWithModel:lastModel];
        [self.volumeMAView maProfileWithModel:lastModel];
//        [self.accessoryMAView maProfileWithModel:lastModel];
    }
}

#pragma mark 重绘
- (void)reDraw
{
    self.kLineMainView.MainViewType = self.MainViewType;
    if(self.targetLineStatus >= 103)
    {
        self.kLineMainView.targetLineStatus = self.targetLineStatus;
    }
    [self.kLineMainView drawMainView];
}


#pragma mark - 私有方法
#pragma mark 画KLineMainView
- (void)private_drawKLineMainView
{
    self.kLineMainView.kLineModels = self.kLineModels;
    [self.kLineMainView drawMainView];
}
- (void)private_drawKLineVolumeView
{
    NSAssert(self.kLineVolumeView, @"kLineVolume不存在");
    //更新约束
    [self.kLineVolumeView layoutIfNeeded];
    [self.kLineVolumeView draw];
}
- (void)private_drawKLineAccessoryView
{
    //更新约束
//    self.accessoryMAView.targetLineStatus = self.targetLineStatus;
//    [self.accessoryMAView maProfileWithModel:_kLineModels.lastObject];
//    [self.kLineAccessoryView layoutIfNeeded];
//    [self.kLineAccessoryView draw];
}
#pragma mark VolumeView代理
- (void)kLineVolumeViewCurrentMaxVolume:(CGFloat)maxVolume minVolume:(CGFloat)minVolume
{
    self.volumeView.maxValue = maxVolume;
    self.volumeView.minValue = minVolume;
    self.volumeView.middleValue = (maxVolume - minVolume)/2 + minVolume;
}
- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice
{
    self.priceView.maxValue = maxPrice;
    self.priceView.minValue = minPrice;
    self.priceView.middleValue = (maxPrice - minPrice)/2 + minPrice;
}
- (void)kLineAccessoryViewCurrentMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue
{
//    self.accessoryView.maxValue = maxValue;
//    self.accessoryView.minValue = minValue;
//    self.accessoryView.middleValue = (maxValue - minValue)/2 + minValue;
}
#pragma mark MainView更新时通知下方的view进行相应内容更新
- (void)kLineMainViewCurrentNeedDrawKLineModels:(NSArray *)needDrawKLineModels
{
    self.kLineVolumeView.needDrawKLineModels = needDrawKLineModels;
//    self.kLineAccessoryView.needDrawKLineModels = needDrawKLineModels;
}
- (void)kLineMainViewCurrentNeedDrawKLinePositionModels:(NSArray *)needDrawKLinePositionModels
{
    self.kLineVolumeView.needDrawKLinePositionModels = needDrawKLinePositionModels;
//    self.kLineAccessoryView.needDrawKLinePositionModels = needDrawKLinePositionModels;
}
- (void)kLineMainViewCurrentNeedDrawKLineColors:(NSArray *)kLineColors
{
    self.kLineVolumeView.kLineColors = kLineColors;
    if(self.targetLineStatus >= 103)
    {
           self.kLineVolumeView.targetLineStatus = self.targetLineStatus;
    }
    [self private_drawKLineVolumeView];
//    self.kLineAccessoryView.kLineColors = kLineColors;
    if(self.targetLineStatus < 103)
    {
//        self.kLineAccessoryView.targetLineStatus = self.targetLineStatus;
    }
    [self private_drawKLineAccessoryView];
}
- (void)kLineMainViewLongPressKLinePositionModel:(Y_KLinePositionModel *)kLinePositionModel kLineModel:(Y_KLineModel *)kLineModel
{
    //更新ma信息
    [self.kLineMAView maProfileWithModel:kLineModel];
    [self.volumeMAView maProfileWithModel:kLineModel];
//    [self.accessoryMAView maProfileWithModel:kLineModel];
}
#pragma mark - UIScrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    static BOOL isNeedPostNotification = YES;
//    if(scrollView.contentOffset.x < scrollView.frame.size.width * 2)
//    {
//        if(isNeedPostNotification)
//        {
//            self.oldExactOffset = scrollView.contentSize.width - scrollView.contentOffset.x;
//            isNeedPostNotification = NO;
//        }
//    } else {
//        isNeedPostNotification = YES;
//    }
    
//    NSLog(@"这是  %f-----%f=====%f",scrollView.contentSize.width,scrollView.contentOffset.x,self.kLineMainView.frame.size.width);
   //NSArray<Y_KLineModel *> *kLineModels
    NSLog(@"偏移量X:%f----偏移量Y:%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    NSInteger index =  scrollView.contentOffset.x/6;
    Y_KLineModel *startModel = self.kLineModels[index];
//    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startModel.Date.doubleValue/1000];
//    NSDateFormatter *formatter = [NSDateFormatter new];
////    formatter.dateFormat = @"HH:mm";
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    NSString *startDateStr = [formatter stringFromDate:startDate];
    NSString *startDateStr = startModel.Date;
    
    
    Y_KLineModel *endModel = self.kLineModels.lastObject;
//    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endModel.Date.doubleValue/1000];
//    NSString *endDateStr = [formatter stringFromDate:endDate];
//    NSLog(@"%@---%@",startDateStr,endDateStr);
    NSString *endDateStr = endModel.Date;
    self.startTimeLab.text = startDateStr;
    self.currentTimeLab.text = endDateStr;
    
    
    
    
    
    //K线价格图位置模型数组
//    self.kLineMainView.needDrawKLinePositionModels;
//
//    //显示当前K线区域的最高最低值
//    //步骤1：获取最高最低所对应的下标
//    int minIndex,maxIndex;
//    float minPrice,maxPrice;
//
//    minPrice = [startModel.Low floatValue];
//    maxPrice = [startModel.High floatValue];
//
//    Y_KLineModel *preMaxModel = self.kLineModels[index];
//    Y_KLineModel *preMinModel = self.kLineModels[index];
////    NSLog(@"%f",(self.frame.size.width-48)/6);
//
//    NSInteger  seeCount = (self.frame.size.width-48)/6;
//    for (NSInteger i =0; i<seeCount-1; i++) {
//
//        Y_KLineModel *currentModel = self.kLineModels[(index+i)];
//        if ([currentModel.High floatValue]> [preMaxModel.High floatValue]) {
//            maxPrice = [currentModel.High floatValue];
//            preMaxModel = self.kLineModels[(index+i)];
//        }
//    }
//    for (NSInteger i =0; i<seeCount-1; i++) {
//        Y_KLineModel *currentModel = self.kLineModels[(index+i)];
//        if ([currentModel.Low floatValue]< [preMinModel.Low floatValue]) {
//            minPrice = [currentModel.Low floatValue];
//            preMinModel = self.kLineModels[(index+i)];
//        }
//    }
//
//    maxIndex = [self.kLineModels indexOfObject:preMaxModel];
//    minIndex = [self.kLineModels indexOfObject:preMinModel];
//
//    NSInteger maxxxx = maxIndex-index;//15
//    NSInteger minxxx = minIndex-index;//27
//
//
//    //步骤2：获取最大值最小值对应的K线坐标
//    Y_KLinePositionModel *maxPositionModel =  self.kLineMainView.needDrawKLinePositionModels[maxIndex-index-1];
//    Y_KLinePositionModel *minPositionModel =  self.kLineMainView.needDrawKLinePositionModels[minIndex-index-1];
//
//
////    UILabel *maxPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(maxPositionModel.HighPoint.x+self.scrollView.contentOffset.x, maxPositionModel.HighPoint.y-20, 30, 1)];
////    maxPriceLab.backgroundColor =[UIColor redColor];
////    [self.kLineMainView addSubview:maxPriceLab];
////
////    UILabel *minPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(minPositionModel.LowPoint.x+self.scrollView.contentOffset.x, minPositionModel.LowPoint.y+30, 30, 1)];
////    minPriceLab.backgroundColor =[UIColor whiteColor];
////    [self.kLineMainView addSubview:minPriceLab];
//    self.kLineMainView.maxPriceLab.frame = CGRectMake(maxPositionModel.HighPoint.x+self.scrollView.contentOffset.x, maxPositionModel.HighPoint.y-20, 30, 1);
//    self.kLineMainView.minPriceLab.frame = CGRectMake(minPositionModel.LowPoint.x+self.scrollView.contentOffset.x, minPositionModel.LowPoint.y+30, 30, 1);
}

- (void)dealloc
{
    [_kLineMainView removeAllObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
