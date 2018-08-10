//
//  KLineFullScreenVC.m
//  BTC-Kline
//
//  Created by  on 2018/7/14.
//  Copyright © 2018年 yate1996. All rights reserved.
//

#import "KLineFullScreenVC.h"
#import "Y_StockChartView.h"
#import "Y_StockChartView.h"
#import "Y_KLineGroupModel.h"
#import "UIColor+Y_StockChart.h"



#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define SCREEN_MAX_LENGTH MAX(kScreenWidth,kScreenHeight)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

@interface KLineFullScreenVC ()<Y_StockChartViewDataSource>

@property (nonatomic, strong) Y_StockChartView *stockChartView;

@property (nonatomic, strong) Y_KLineGroupModel *groupModel;

@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;


@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *type;
@property(nonatomic,assign) BOOL isFullScreen;

@end

@implementation KLineFullScreenVC
#pragma mark - 控制器初始化方法
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.isFullScreen = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.stockChartView.backgroundColor = [UIColor colorWithHex:@"#ffffff"];

    self.currentIndex = -1;
    //设置屏幕横向
    self.isFullScreen = YES;
    
    // Do any additional setup after loading the view.
}


- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}
#pragma mark  退出全屏点击
-(void)fullScreenClick{
//    self.isFullScreen = NO;
//    [self dismissViewControllerAnimated:YES completion:nil];
 
    [self dismissViewControllerAnimated:nil completion:^{
//        self.isFullScreen = NO;
    }];
}
#pragma mark 请求数据
-(id) stockDatasWithIndex:(NSInteger)index
{
    NSLog(@"当前选中的是%ld",(long)index);
    NSString *type;
    switch (index) {
        case 0:
        {
            type = @"15min";
        }
            break;
        case 1:
        {
            type = @"30min";
        }
            break;
        case 2:
        {
            type = @"1hour";
        }
            break;
        case 3:
        {
            type = @"1day";
        }
            break;
        default:
            break;
    }

    self.currentIndex = index;
    self.type = type;
    if(![self.modelsDict objectForKey:type])
    {
        [self reloadData];
    } else {
        return [self.modelsDict objectForKey:type].models;
    }
    return nil;
}

- (void)reloadData
{
    NSString *urlPath;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (self.currentIndex==0) {
        urlPath = [NSString stringWithFormat:@"%@/kline/get_kline_15m",SERVER];
        param[@"tradePlatform"] = @"bitfinex";
        param[@"coinPair"] = @"eth_btc";
        param[@"klineDate"] = @"20180801";
    }
    else if (self.currentIndex==1){
        urlPath = [NSString stringWithFormat:@"%@/kline/get_kline_30m",SERVER];
        param[@"tradePlatform"] = @"bitfinex";
        param[@"coinPair"] = @"eth_btc";
        param[@"klineDate"] = @"20180801";
    }
    else if (self.currentIndex==2){
        urlPath = [NSString stringWithFormat:@"%@/kline/get_kline_1h",SERVER];
        param[@"tradePlatform"] = @"bitfinex";
        param[@"coinPair"] = @"eth_btc";
        param[@"klineDate"] = @"20180801";
    }
    else if (self.currentIndex==3){
        urlPath = [NSString stringWithFormat:@"%@/kline/get_kline_1d",SERVER];
        param[@"tradePlatform"] = @"bitfinex";
        param[@"coinPair"] = @"eth_btc";
    }
    
    [NetworkManage Get:urlPath andParams:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray* reversedArray = [[responseObject[@"data"] reverseObjectEnumerator] allObjects];
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:reversedArray];
        self.groupModel = groupModel;
        [self.modelsDict setObject:groupModel forKey:self.type];
        //        NSLog(@"%@",groupModel);
        [self.stockChartView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (Y_StockChartView *)stockChartView
{
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.isFullScreen = YES;
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"15分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"30分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"1小时" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"1天" type:Y_StockChartcenterViewTypeKline],
                                       ];
        
        _stockChartView.backgroundColor = [UIColor orangeColor];
        _stockChartView.dataSource = self;
        [self.view addSubview:_stockChartView];
        [_stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (IS_IPHONE_X) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(44);
                make.bottom.mas_equalTo(-34);
                make.right.mas_equalTo(0);
            } else {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.right.mas_equalTo(0);
            }
    
        }];
    }
    return _stockChartView;
}


#pragma mark  set方法  设置是否需要全屏的方法
-(void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    if (isFullScreen) {
        //横竖屏设置
        [UIView animateWithDuration:0.5f animations:^{
            [[UIDevice currentDevice] setValue:
             [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
        }];
        NSLog(@"%f--横屏--%f",SCREEN_WIDTH, SCREEN_HEIGHT);//375.000000--横屏--667.000000
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            [[UIDevice currentDevice] setValue:
             [NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
        }];
        NSLog(@"%f--竖屏--%f",SCREEN_WIDTH, SCREEN_HEIGHT);//375.000000--竖屏--667.000000
    }
}


#pragma mark - 屏幕旋转相关方法
#pragma mark 是否支持自动旋转
-(BOOL)shouldAutorotate
{
    return YES;
}
#pragma mark 支持的方向
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
