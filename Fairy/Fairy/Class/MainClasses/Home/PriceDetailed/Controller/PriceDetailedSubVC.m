//
//  PriceDetailedSubVC.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceDetailedSubVC.h"
#import "PriceAnalyzeView.h"
#import "PriceIntroduceView.h"
#import "PriceForecastView.h"
#import "PriceDetailDataView.h"
#import "AbstractView.h"


@interface PriceDetailedSubVC ()

@property(nonatomic,strong)PriceAnalyzeView *analyzeView;
@property(nonatomic,strong)PriceIntroduceView *introduceView;
@property(nonatomic,strong)PriceForecastView *forecastView;
@property (nonatomic,strong) PriceModel *priceModel;
@property(nonatomic,strong)NSArray *typeDataArr;
@end

@implementation PriceDetailedSubVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithHex:@"#f1f2f4"];
    
    // Do any additional setup after loading the view.
}

-(void)loadMainTableData:(NSString*)selectType Index:(NSInteger)index PriceModel:(PriceModel *)priceModel{
    NSLog(@"%@---%ld",selectType,index);
    self.priceModel = priceModel;
    //60 +180 +10 + 35 + 30
    NSInteger height = SCREEN_HEIGHT - LL_TabbarSafeBottomMargin - LL_StatusBarAndNavigationBarHeight - 315;
    if ([selectType isEqualToString:@"分析"]) {
        if (index==0) {
//            PriceIntroduceView *view =[[PriceIntroduceView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
//            self.introduceView = view;
//            [self.view addSubview:view];
            AbstractView *DataVc  =[[AbstractView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
            self.introduceView = DataVc;
            [self.view addSubview:DataVc];
            
            
            [self requestJieShao];
            
        }
        else{
            NSDictionary *dict = self.typeDataArr[index-1];
            PriceAnalyzeView *view =[[PriceAnalyzeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) FenXi:dict[@"content"]];
            self.analyzeView = view;
            [self.view addSubview:view];
            
            [self requestDatas:index];
            
        }
        
    }
    else if ([selectType isEqualToString:@"预测"]){
        PriceForecastView *view =[[PriceForecastView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        self.forecastView = view;
        [self.view addSubview:view];
        [self requestDuanQiYuCe];
    }
    else if ([selectType isEqualToString:@"数据"]){
        PriceDetailDataView *DataVc  =[[PriceDetailDataView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];

        self.forecastView = DataVc;
        [self.view addSubview:DataVc];
        //        [self requestDuanQiYuCe];
    }
    else if ([selectType isEqualToString:@"简介"]){
        AbstractView *DataVc  =[[AbstractView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        self.forecastView = DataVc;
        [self.view addSubview:DataVc];
        //        [self requestDuanQiYuCe];
    }
    
    
    else{ //预警
        
    }
    
}
-(void)requestJieShao{
    NSString *fsymStr = [self.priceModel.fsym lowercaseString];
    NSString *path = [NSString stringWithFormat:@"%@%@",PriceIntroduce,fsymStr];
    [NetworkManage Get:path andParams:nil success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            [self.introduceView setDataDic:obj[@"data"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)requestDatas:(NSInteger)type{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    NSString *fsymStr = [self.priceModel.fsym lowercaseString];
    dict[@"coin"] = fsymStr;
    dict[@"type"] = self.typeDataArr[type-1][@"type"];
    
    [NetworkManage Get:PriceAnalyze andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            
            [self.analyzeView setDataDic:obj[@"data"]];
            /*
             {
             "code": 200,
             "message": "操作成功",
             "data": {
             "image": "/image/statistics/Statistics_googlevscoin_btc.png",
             "data": {
             "date": "2018-08-01",
             "btc": "0.04923597542130377",
             "close": "0.3657735939366355"
             }
             }
             }
             */
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(NSArray*)typeDataArr{
    if (!_typeDataArr) {
        _typeDataArr = @[@{@"type":@"coincorelation",@"content":@"用协整分析法分析各点和位点之间的相互关系"},
                         @{@"type":@"coinvscoin",@"content":@"在两个币之间进行币的对比"},
                         @{@"type":@"coinchgvscoinchg",@"content":@"在币变化之间进行对比"},
                         @{@"type":@"googlevscoin",@"content":@"google关注度的增长与币价格的对比"},
                         @{@"type":@"metalvscoin",@"content":@"贵重金属与币价格变化的百分比之间的关系"},
                         @{@"type":@"orilvscoin",@"content":@"原油与币价格变化的百分比之间的关系"},
                         @{@"type":@"redditvscoin",@"content":@"reddit关注度与币价格之间的关系"},
                         @{@"type":@"exchangeratevscoin",@"content":@"汇率与币价格之间的关系"},
                         ];
    }
    return _typeDataArr;
}

-(void)requestDuanQiYuCe{
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    NSString *fsymStr = [self.priceModel.fsym lowercaseString];
    dict[@"coin"] = fsymStr;
    [NetworkManage Get:PriceForecast andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            [self.forecastView setDataDic:obj[@"data"]];
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
