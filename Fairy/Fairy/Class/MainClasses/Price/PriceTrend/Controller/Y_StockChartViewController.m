//
//  YStockChartViewController.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/27.
//  Copyright © 2016年 yate1996. All rights reserved.
//


/*
 数组第一条数据为时间最近
 日期       _Date = arr[0];
 开盘价     _Open = @([arr[1] floatValue]);
 最高价     _High = @([arr[2] floatValue]);
 最低价     _Low = @([arr[3] floatValue]);
 收盘价     _Close = @([arr[4] floatValue]);
 成交量     _Volume = [arr[5] floatValue];
 (
 1532665800000,
 "7930.82",
 "7946.1",
 "7920.75",
 "7936.79",
 "409.4289"
 ),
 
 1.获取当前K线内的开始时间和结束时间 (当前偏移量除以K线宽+K线间隔宽，得到当前第一个K线对应的模型)
 2.点击全屏
 3.向左滑动，分页加载
 4.显示当前K线区域的最高最低值
 */




#import "Y_StockChartViewController.h"
#import "Y_StockChartView.h"
#import "Y_KLineGroupModel.h"
#import "UIColor+Y_StockChart.h"

#import "KLineFullScreenVC.h"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define SCREEN_MAX_LENGTH MAX(kScreenWidth,kScreenHeight)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

@interface Y_StockChartViewController ()<Y_StockChartViewDataSource>

@property (nonatomic, strong) Y_StockChartView *stockChartView;

@property (nonatomic, strong) Y_KLineGroupModel *groupModel;

@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;


@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *type;

@end

@implementation Y_StockChartViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.view setNeedsLayout];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.stockChartView.backgroundColor = [UIColor backgroundColor];
    self.currentIndex = -1;
    
    // Do any additional setup after loading the view.

}

- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of  nmthat can be recreated.
}
#pragma mark 全屏点击
-(void)fullScreenClick{
    KLineFullScreenVC *vc =[KLineFullScreenVC new];
    UIViewController *currentVC = [Tool getCurrentVC];
    [currentVC presentViewController:vc animated:YES completion:nil];
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
        urlPath = @"http://47.75.145.77:8080/interface/kline/get_kline_15m";
        param[@"tradePlatform"] = @"bitfinex";
        param[@"coinPair"] = @"eth_btc";
        param[@"klineDate"] = @"20180801";
    }
    else if (self.currentIndex==1){
        urlPath = @"http://47.75.145.77:8080/interface/kline/get_kline_30m";
        param[@"tradePlatform"] = @"bitfinex";
        param[@"coinPair"] = @"eth_btc";
        param[@"klineDate"] = @"20180801";
    }
    else if (self.currentIndex==2){
        urlPath = @"http://47.75.145.77:8080/interface/kline/get_kline_1h";
        param[@"tradePlatform"] = @"bitfinex";
        param[@"coinPair"] = @"eth_btc";
        param[@"klineDate"] = @"20180801";
    }
    else if (self.currentIndex==3){
        urlPath = @"http://47.75.145.77:8080/interface/kline/get_kline_1d";
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
        NSLog(@"%@",error)
    }];

}
- (Y_StockChartView *)stockChartView
{
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.isFullScreen = NO;
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
            make.top.mas_equalTo(88);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(400);
    
        }];
    }
    return _stockChartView;
}

@end
