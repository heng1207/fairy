//
//  TrendSubVC.m
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 . All rights reserved.
//

#import "TrendSubVC.h"
#import "LDLineChartView.h"
#import "CompareChartView.h"

#define chartViewHeight  (SCREEN_HEIGHT-LL_TabbarSafeBottomMargin-30-LL_StatusBarAndNavigationBarHeight-30-40)/2

@interface TrendSubVC ()

@property(nonatomic,strong)UIButton *firstBtn;
@property(nonatomic,strong)UIButton *secondBtn;
@property(nonatomic,strong)CompareChartView *wsLine;
@property(nonatomic,strong)CompareChartView *volumeLine;
@property(nonatomic,strong)NSMutableArray *firstPrices;
@property(nonatomic,strong)NSMutableArray *firstVolume;

@property(nonatomic,strong)NSMutableArray *priceTrendData;
@property(nonatomic,strong)NSMutableArray *volumeTrendData;


@end

@implementation TrendSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithHex:@"#e9eff8"];
    
    [self creatHintView];
    [self creatToolBarView];
    
    [self requestPriceDatas];
   
    
    
    // Do any additional setup after loading the view.
}
-(void)creatHintView{
    UILabel *hintLab =[[UILabel alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH-24, 40)];
    hintLab.text =@"风险提示：短线助手仅供参考，不构成投资建议，市场有风险，需谨慎操作";
    hintLab.numberOfLines=0;
    hintLab.font = [UIFont systemFontOfSize:10];
    hintLab.textColor =[UIColor grayColor];
    [self.view addSubview:hintLab];
}

-(void)creatToolBarView{
    
    NSLog(@"%f",self.view.frame.size.height);
    UIView *toolBar =[[UIView alloc]initWithFrame:CGRectMake(0,  SCREEN_HEIGHT-LL_TabbarSafeBottomMargin-30-LL_StatusBarAndNavigationBarHeight-30, SCREEN_WIDTH, 30)];
    [self.view addSubview:toolBar];
    toolBar.backgroundColor =[UIColor whiteColor];
    [toolBar borderForColor:[UIColor grayColor] borderWidth:1 borderType:UIBorderSideTypeTop];
    
    UIButton *ZBbtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, toolBar.width/2, 30)];
    self.firstBtn = ZBbtn;
    ZBbtn.backgroundColor= [UIColor colorWithHex:@"#e6e6e7"];
    [ZBbtn setImage:[UIImage imageNamed:@"platform_normol"] forState:UIControlStateNormal];
    [toolBar addSubview:ZBbtn];
    [ZBbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ZBbtn setTitle:self.priceModel.platformCnName forState:UIControlStateNormal];
    
    
    UIButton *Bibtn =[[UIButton alloc]initWithFrame:CGRectMake(toolBar.width/2, 0, toolBar.width/2, 30)];
    [toolBar addSubview:Bibtn];
    self.secondBtn = Bibtn;
    [Bibtn setImage:[UIImage imageNamed:@"platform_select"] forState:UIControlStateNormal];
    Bibtn.backgroundColor= [UIColor colorWithHex:@"#e6e6e7"];
    [Bibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Bibtn addTarget:self action:@selector(BitClick) forControlEvents:UIControlEventTouchUpInside];
    if ([self.priceModel.platformCnName isEqualToString:@"中币"]) {
        [self.secondBtn setTitle:@"BITFINEX" forState:UIControlStateNormal];
    }
    else{
        [self.secondBtn setTitle:@"中币" forState:UIControlStateNormal];
    }
    
}


-(void)BitClick{
    
//    NSMutableArray *items = [NSMutableArray array];
//    [items addObject:[YCXMenuItem menuItem:@"中币" image:nil tag:1 userInfo:@{@"title":@"Menu"}]];
//    [items addObject:[YCXMenuItem menuItem:@"bit" image:nil tag:2 userInfo:@{@"title":@"Menu"}]];
//
//    [YCXMenu showMenuInView:self.view fromRect:CGRectMake(UIScreenW-100, SCREEN_HEIGHT-LL_TabbarSafeBottomMargin-30-LL_StatusBarAndNavigationBarHeight-30, 50, 50) menuItems:items selected:^(NSInteger index, YCXMenuItem *item) {
//        NSLog(@"%@",item.title);
//    }];
    
    
    NSString *str= [self.secondBtn titleForState:UIControlStateNormal];
    if ([str isEqualToString:@"中币"]) {
        [self requestPriceDatas:@"zb"];
        [self requestVolumeDatas:@"zb"];
    }
    else{
        [self requestPriceDatas:@"bitfinex"];
        [self requestVolumeDatas:@"bitfinex"];
    }
    
    
}

#pragma mark  价格
-(void)requestPriceDatas{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    if ([self.priceModel.platformCnName isEqualToString:@"中币"]) {
        dict[@"tradePlatform"] = @"zb";
    }
    else{
        dict[@"tradePlatform"] = @"bitfinex";

    }
    NSString *coinPairStr = [NSString stringWithFormat:@"%@_%@", self.priceModel.fsym, self.priceModel.tsyms];
    dict[@"coinPair"] = [coinPairStr lowercaseString];
    
    [NetworkManage Get:PriceTrendChart andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            NSArray *priceArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
            self.priceTrendData = [NSMutableArray arrayWithArray:priceArr];
            //获取 Price 显示区间最大值，最小值
            NSMutableArray *price = [NSMutableArray array];
            for (NSDictionary *item in priceArr) {
                [price addObject: [NSNumber numberWithFloat:[item[@"close"] floatValue]]];
            }
            CGFloat maxPrice = [[price valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minPrice = [[price valueForKeyPath:@"@min.floatValue"] floatValue];
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *yArrays = [NSMutableArray array];
            NSMutableArray *yArray0 = [NSMutableArray array];
            
            [priceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"timestamp"]];
                [yArray0 addObject:obj[@"close"]];
            }];
            [yArrays addObject:yArray0];
            self.firstPrices =[NSMutableArray arrayWithArray:yArray0];
            
            
            CompareChartView *wsLine = [[CompareChartView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, chartViewHeight) xTitleArray:xArray yValueArray:yArrays yMax:maxPrice yMin:minPrice LineType:@"价格 USD"];
            self.wsLine =wsLine;
            [self.view addSubview:wsLine];
            
            [self requestVolumeDatas];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)requestPriceDatas:(NSString*)platformType{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    dict[@"tradePlatform"] = platformType;
    NSString *coinPairStr = [NSString stringWithFormat:@"%@_%@", self.priceModel.fsym, self.priceModel.tsyms];
    dict[@"coinPair"] = [coinPairStr lowercaseString];
    
    [NetworkManage Get:PriceTrendChart andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            NSArray *priceArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
          
            //获取 Price 显示区间最大值，最小值
            NSMutableArray *price = [NSMutableArray array];
            for (NSDictionary *item in priceArr) {
                [price addObject: [NSNumber numberWithFloat:[item[@"close"] floatValue]]];
            }
            for (NSDictionary *item in self.priceTrendData) {
                [price addObject: [NSNumber numberWithFloat:[item[@"close"] floatValue]]];
            }
            CGFloat maxPrice = [[price valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minPrice = [[price valueForKeyPath:@"@min.floatValue"] floatValue];
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *yArrays = [NSMutableArray array];
            NSMutableArray *yArray1 = [NSMutableArray array];
            
            [priceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"timestamp"]];
                [yArray1 addObject:obj[@"close"]];
            }];
            [yArrays addObject:self.firstPrices];
            [yArrays addObject:yArray1];
            
            if (self.wsLine) {
                [self.wsLine removeFromSuperview];
                self.wsLine = nil;
            }
            CompareChartView *wsLine = [[CompareChartView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, chartViewHeight) xTitleArray:xArray yValueArray:yArrays yMax:maxPrice yMin:minPrice LineType:@"价格 USD"];
            self.wsLine =wsLine;
            [self.view addSubview:wsLine];
          
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



#pragma mark  成交量
-(void)requestVolumeDatas{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    if ([self.priceModel.platformCnName isEqualToString:@"中币"]) {
        dict[@"tradePlatform"] = @"zb";
    }
    else{
        dict[@"tradePlatform"] = @"bitfinex";
        
    }
    NSString *coinPairStr = [NSString stringWithFormat:@"%@_%@", self.priceModel.fsym, self.priceModel.tsyms];
    dict[@"coinPair"] = [coinPairStr lowercaseString];
    
    [NetworkManage Get:VolumeTrendChart andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {

            NSArray *volumeArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
            self.volumeTrendData =[NSMutableArray arrayWithArray:volumeArr];

            //获取 Volume 显示区间最大值，最小值
            NSMutableArray *volume = [NSMutableArray array];
            for (NSDictionary *item in volumeArr ) {
                [volume addObject: [NSNumber numberWithFloat:[item[@"volume"] floatValue]]];
            }
            CGFloat maxVolume = [[volume valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minVolume = [[volume valueForKeyPath:@"@min.floatValue"] floatValue];

            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *yArrays = [NSMutableArray array];
            NSMutableArray *yArray0 = [NSMutableArray array];
            
            [volumeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"timestamp"]];
                [yArray0 addObject:obj[@"volume"]];
            }];
            [yArrays addObject:yArray0];
            self.firstVolume =[NSMutableArray arrayWithArray:yArray0];
            
            
            CompareChartView *volumeLine = [[CompareChartView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.wsLine.frame), SCREEN_WIDTH, chartViewHeight) xTitleArray:xArray yValueArray:yArrays yMax:maxVolume yMin:minVolume LineType:@"成交量 USD"];
            self.volumeLine =volumeLine;
            [self.view addSubview:volumeLine];
            
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)requestVolumeDatas:(NSString*)platformType{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"tradePlatform"] = platformType;
    NSString *coinPairStr = [NSString stringWithFormat:@"%@_%@", self.priceModel.fsym, self.priceModel.tsyms];
    dict[@"coinPair"] = [coinPairStr lowercaseString];
    
    [NetworkManage Get:VolumeTrendChart andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            
            NSArray *volumeArr = [[obj[@"data"] reverseObjectEnumerator] allObjects];
            
            
            //获取 Volume 显示区间最大值，最小值
            NSMutableArray *volume = [NSMutableArray array];
            for (NSDictionary *item in volumeArr ) {
                [volume addObject: [NSNumber numberWithFloat:[item[@"volume"] floatValue]]];
            }
            for (NSDictionary *item in self.volumeTrendData ) {
                [volume addObject: [NSNumber numberWithFloat:[item[@"volume"] floatValue]]];
            }
            CGFloat maxVolume = [[volume valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minVolume = [[volume valueForKeyPath:@"@min.floatValue"] floatValue];
            
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *yArrays = [NSMutableArray array];
            NSMutableArray *yArray1 = [NSMutableArray array];
            
            [volumeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"timestamp"]];
                [yArray1 addObject:obj[@"volume"]];
            }];
            [yArrays addObject:self.firstVolume];
            [yArrays addObject:yArray1];
      
            
            if (self.volumeLine) {
                [self.volumeLine removeFromSuperview];
                self.volumeLine = nil;
            }
            CompareChartView *volumeLine = [[CompareChartView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.wsLine.frame), SCREEN_WIDTH, chartViewHeight) xTitleArray:xArray yValueArray:yArrays yMax:maxVolume yMin:minVolume LineType:@"成交量 USD"];
            self.volumeLine =volumeLine;
            [self.view addSubview:volumeLine];
            
            
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
