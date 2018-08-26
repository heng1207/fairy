//
//  TrendSubVC.m
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 . All rights reserved.
//

#import "TrendSubVC.h"
#import "LDLineChartView.h"

@interface TrendSubVC ()
@property(nonatomic,strong)NSMutableArray *priceTrendData;
@property(nonatomic,strong)NSMutableArray *volumeTrendData;


@end

@implementation TrendSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithHex:@"#eeeeee"];

    
    
    [self requestPriceDatas];
    
    
    // Do any additional setup after loading the view.
}

-(void)requestPriceDatas{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
//    dict[@"tradePlatform"] = @"bitfinex";
//    dict[@"coinPair"] = @"eth_btc";
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tradePlatformStr = [defaults objectForKey:@"platformCnName"];
    dict[@"tradePlatform"] = [tradePlatformStr lowercaseString];
    
    NSString *coinPairStr = [NSString stringWithFormat:@"%@_%@", self.priceModel.fsym, self.priceModel.tsyms];
    dict[@"coinPair"] = [coinPairStr lowercaseString];
//    dict[@"coinPair"] = [NSString stringWithFormat:@"%@_%@", self.priceModel.fsym, self.priceModel.tsyms];
    
    [NetworkManage Get:PriceTrendChart andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
//            self.priceTrendData = obj[@"data"];
            NSArray *priceArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
            self.priceTrendData = [NSMutableArray arrayWithArray:priceArr];
            
            [self requestVolumeDatas];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)requestVolumeDatas{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
//    dict[@"tradePlatform"] = @"bitfinex";
//    dict[@"coinPair"] = @"eth_btc";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tradePlatformStr = [defaults objectForKey:@"platformCnName"];
    dict[@"tradePlatform"] = [tradePlatformStr lowercaseString];
    
    NSString *coinPairStr = [NSString stringWithFormat:@"%@_%@", self.priceModel.fsym, self.priceModel.tsyms];
    dict[@"coinPair"] = [coinPairStr lowercaseString];
    
    [NetworkManage Get:VolumeTrendChart andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
//            self.volumeTrendData = obj[@"data"];
            NSArray *volumeArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
            self.volumeTrendData = [NSMutableArray arrayWithArray:volumeArr];
            
            
            //获取 Price 显示区间最大值，最小值
            NSMutableArray *price = [NSMutableArray array];
            for (NSDictionary *item in self.priceTrendData ) {
                [price addObject: [NSNumber numberWithFloat:[item[@"close"] floatValue]]];
            }
            CGFloat maxPrice = [[price valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minPrice = [[price valueForKeyPath:@"@min.floatValue"] floatValue];
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *yArray = [NSMutableArray array];
 
            [self.priceTrendData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"timestamp"]];
                [yArray addObject:obj[@"close"]];
            }];
            
            
            //获取 Volume 显示区间最大值，最小值
            NSMutableArray *volume = [NSMutableArray array];
            for (NSDictionary *item in obj[@"data"] ) {
                [volume addObject: [NSNumber numberWithFloat:[item[@"volume"] floatValue]]];
            }
            CGFloat maxVolume = [[volume valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minVolume = [[volume valueForKeyPath:@"@min.floatValue"] floatValue];

            NSMutableArray *xArrayUnder = [NSMutableArray array];
            NSMutableArray *yArrayUnder = [NSMutableArray array];

            [self.volumeTrendData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArrayUnder addObject:obj[@"timestamp"]];
                [yArrayUnder addObject:obj[@"volume"]];
            }];
            
            LDLineChartView *wsLine = [[LDLineChartView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - LL_StatusBarAndNavigationBarHeight -LL_TabbarSafeBottomMargin - 30) xTitleArray:xArray yValueArray:yArray yMax:maxPrice yMin:minPrice yValueArrayUnder:yArrayUnder yMaxUnder:maxVolume yMin:minVolume];
            [self.view addSubview:wsLine];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
