//
//  PriceDetailedSubVC.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceDetailedSubVC.h"
#import "PriceAnalyzeView.h"

@interface PriceDetailedSubVC ()

@property(nonatomic,strong)PriceAnalyzeView *analyzeView;
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
-(void)loadMainTableData:(NSInteger )type isPull:(BOOL)isPull{
    NSLog(@"%ld",(long)type);
    
    //60 +180 +10 + 35 + 30
    NSInteger height = SCREEN_HEIGHT - LL_TabbarSafeBottomMargin - LL_StatusBarAndNavigationBarHeight - 315;
    if (type==0) {
        PriceAnalyzeView *view =[[PriceAnalyzeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) FenXi:@""];
        self.analyzeView = view;
        [self.view addSubview:view];
    }
    else{
        NSDictionary *dict = self.typeDataArr[type-1];
        PriceAnalyzeView *view =[[PriceAnalyzeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) FenXi:dict[@"content"]];
        self.analyzeView = view;
        [self.view addSubview:view];
        
    }

    if (type==0) {
        [self requestJieShao];
    }
    else{
        [self requestDatas:type];
    }

}
-(void)requestJieShao{
    NSString *path = @"http://47.75.145.77:8080/interface/digital_currency/viewByshortEnName/btc";
    [NetworkManage Get:path andParams:nil success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            NSArray *dataDic= obj[@"data"];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)requestDatas:(NSInteger)type{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"coin"] = @"btc";
    dict[@"type"] = self.typeDataArr[type-1][@"type"];
    
    [NetworkManage Get:statistics andParams:dict success:^(id responseObject) {
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
