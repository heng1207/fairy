//
//  PriceDetailedVC.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "PriceDetailedVC.h"
#import "PriceDetailedSubVC.h"
#import "IndexView.h"
#import "BaseTypeView.h"
#import "WSLineChartView.h"

#import "CurrencySelectVC.h"
#import "TrendVC.h"

@interface PriceDetailedVC ()<BaseTypeViewDelegate,WSLineChartViewDelegate>

@property(nonatomic,strong)IndexView *indexView;
@property(nonatomic,strong)WSLineChartView *lineChartView;
@property(nonatomic,strong)BaseTypeView *baseTypeView;
@property(nonatomic,strong)NSString *selectTpye;

@property(nonatomic,strong) NSArray *firstDataArr;
@property(nonatomic,strong) NSArray *secondDataArr;

@property(nonatomic,strong) NSMutableArray *flagArray;
@property (nonatomic, strong) NSMutableArray *titleItemLengths;
@end

@implementation PriceDetailedVC

- (void)viewDidLoad {
    
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressColor =[UIColor colorWithHex:@"#1161a0"];
    self.progressHeight = 1;
    self.flagArray =[NSMutableArray array];
    self.titleItemLengths =[NSMutableArray array];
    for (NSInteger i =0; i<self.flagArray.count; i++) {
        CGSize size = [self methodForitleItemLengths:self.flagArray[i] ];
        NSNumber *width = [NSNumber numberWithFloat:size.width];
        [self.titleItemLengths addObject:width];
    }
    self.progressViewWidths = self.titleItemLengths;
    self.itemsWidths = self.titleItemLengths;
    self.itemMargin = 20;
    self.progressViewBottomSpace=2;
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.titleSizeNormal = 15;
    self.titleSizeSelected = 15;
    self.titleColorNormal = [UIColor colorWithHex:@"#848484"];
    self.titleColorSelected = [UIColor colorWithHex:@"#0e5f9f"];
    self.menuView.scrollView.backgroundColor =[UIColor grayColor];
    
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initNavtionBar];
    [self creatPriceView];
    
    
    [self requestData];
    
    // Do any additional setup after loading the view.
}

-(void)initNavtionBar{
    UIView *viewTitle = [[UIView alloc] init];
    viewTitle.frame = CGRectMake(0, 0, 150, 36);

    UILabel *fromLab =[[ UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 18)];
    fromLab.font = AdaptedFontSize(30);
    fromLab.textColor = [UIColor whiteColor];
    fromLab.textAlignment = NSTextAlignmentCenter;
    fromLab.text = self.priceModel.platformCnName;
    [viewTitle addSubview:fromLab];
    
    UILabel *nameLab =[[ UILabel alloc]initWithFrame:CGRectMake(0, 18, 150, 18)];
    nameLab.font = AdaptedFontSize(30);
    nameLab.textColor = [UIColor whiteColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.text = [NSString stringWithFormat:@"%@/%@",self.priceModel.fsym,self.priceModel.tsyms];
    [viewTitle addSubview:nameLab];
    
    self.navigationItem.titleView =viewTitle;

    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    
    UIButton *search = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [search setImage:[UIImage imageNamed:@"searchLogo"] forState:UIControlStateNormal];
    [search addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:search];
    
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchClick{

}


-(void)creatPriceView{
    IndexView *indexView =[[IndexView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 60)];
    self.indexView = indexView;
    [indexView setPriceModel:self.priceModel];
    indexView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:indexView];
    
}

-(void)creatBaseTypeView{
    BaseTypeView *baseTypeView =[[BaseTypeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineChartView.frame)+10, UIScreenW, 35)];
    self.baseTypeView = baseTypeView;
    baseTypeView.delegate = self;
    [self.view addSubview:baseTypeView];
}

#pragma mark - Datasource & Delegate
#pragma mark 返回子页面的个数
-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.flagArray.count;
}

#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    PriceDetailedSubVC *vc = [[PriceDetailedSubVC alloc]init];
    [vc loadMainTableData:self.selectTpye Index:index PriceModel:self.priceModel];
    return vc;
}
#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.flagArray[index];
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    return  CGRectMake(0, CGRectGetMaxY(self.baseTypeView.frame), SCREEN_WIDTH, 30);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return  CGRectMake(0, CGRectGetMaxY(self.baseTypeView.frame)+30, SCREEN_WIDTH, CGRectGetHeight(self.view.frame)- CGRectGetMaxY(self.baseTypeView.frame)-30 );
}

#pragma mark BaseTypeViewDelegate
-(void)gmdOpFenXiClick{
    [self fenXiData];
}

-(void)fenXiData{
    self.selectTpye = @"分析";
    [self.flagArray removeAllObjects];
    [self.titleItemLengths  removeAllObjects];
    self.flagArray = [NSMutableArray arrayWithObjects:@"介绍",@"协整分析",@"币币比较",@"币变化对比",@"google关注与比价格关系",@"贵重金属与币价格关系",@"原油与币价格的关系",@"reddit关注度与币价格关系",@"汇率与币价格关系", nil];
    
    for (NSInteger i =0; i<self.flagArray.count; i++) {
        CGSize size = [self methodForitleItemLengths:self.flagArray[i] ];
        NSNumber *width = [NSNumber numberWithFloat:size.width];
        [self.titleItemLengths addObject:width];
    }
    self.progressViewWidths = self.titleItemLengths;
    self.itemsWidths = self.titleItemLengths;
    [self reloadData];
}

-(void)gmdOpYuCeClick{

    self.selectTpye = @"预测";
    [self.flagArray removeAllObjects];
    [self.titleItemLengths  removeAllObjects];
    self.flagArray = [NSMutableArray arrayWithObjects:@"短期预测", nil];
    for (NSInteger i =0; i<self.flagArray.count; i++) {
        CGSize size = [self methodForitleItemLengths:self.flagArray[i] ];
        NSNumber *width = [NSNumber numberWithFloat:size.width];
        [self.titleItemLengths addObject:width];
    }
    self.progressViewWidths = self.titleItemLengths;
    self.itemsWidths = self.titleItemLengths;
    [self reloadData];
}
-(void)gmdOpYuJingClick{
    self.selectTpye = @"预警";
    [self.flagArray removeAllObjects];
    [self.titleItemLengths  removeAllObjects];
    self.flagArray = [NSMutableArray arrayWithObjects:@"币地址检测",@"交易量预警",@"换手量预警", nil];
    for (NSInteger i =0; i<self.flagArray.count; i++) {
        CGSize size = [self methodForitleItemLengths:self.flagArray[i] ];
        NSNumber *width = [NSNumber numberWithFloat:size.width];
        [self.titleItemLengths addObject:width];
    }
    self.progressViewWidths = self.titleItemLengths;
    self.itemsWidths = self.titleItemLengths;
    [self reloadData];
    
}

#pragma mark WSLineChartViewDelegate
-(void)xAxisViewTapClick{
    TrendVC *vc=[TrendVC new];
    vc.priceModel = self.priceModel;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)xAxisViewCompareClick{
    CurrencySelectVC *vc=[CurrencySelectVC new];
    vc.block = ^(NSString *content) {
        [self requestSelectData:content];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)requestData{

    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPair"] = self.priceModel.fsym;
    [NetworkManage Get:coinmarketcapHistory andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            self.firstDataArr = obj[@"data"];
            
            //获取显示区间最大值，最小值
            NSMutableArray *price = [NSMutableArray array];
            for (NSDictionary *item in obj[@"data"] ) {
                [price addObject: [NSNumber numberWithFloat:[item[@"closePrice"] floatValue]]];
            }
            CGFloat maxPrice = [[price valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minPrice = [[price valueForKeyPath:@"@min.floatValue"] floatValue];
            int maxSection = (maxPrice/10);
            int minSection = (minPrice/10);
            int maxPriceSection = maxSection*10+10;
            int minPriceSection = minSection*10;
//            NSLog(@"%f---%f",maxPrice,minPrice);
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *yArrays = [NSMutableArray array];
            NSMutableArray *yArray0 = [NSMutableArray array];
            [obj[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"historyDate"]];
                [yArray0 addObject:obj[@"closePrice"]];
            }];
            [yArrays addObject:yArray0];
            
            WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indexView.frame), UIScreenW, 180) xTitleArray:xArray yValueArray:yArrays yMax:maxPriceSection yMin:minPriceSection];
            self.lineChartView = wsLine;
            wsLine.delegate = self;
            [self.view addSubview:wsLine];
    
            [self creatBaseTypeView];
            [self fenXiData];
      
            
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)requestSelectData:(NSString*)type{
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    dict[@"coinPair"] = type;
    [NetworkManage Get:coinmarketcapHistory andParams:dict success:^(id responseObject) {
        NSMutableDictionary *obj = (NSMutableDictionary*)responseObject;
        if ([obj[@"code"] integerValue] ==200 ) {
            self.secondDataArr = obj[@"data"];
            
            //获取显示区间最大值，最小值
            NSMutableArray *price = [NSMutableArray array];
            for (NSDictionary *item in obj[@"data"] ) {
                [price addObject: [NSNumber numberWithFloat:[item[@"closePrice"] floatValue]]];
            }
            for (NSDictionary *item in self.firstDataArr) {
                [price addObject: [NSNumber numberWithFloat:[item[@"closePrice"] floatValue]]];
            }
            CGFloat maxPrice = [[price valueForKeyPath:@"@max.floatValue"] floatValue];
            CGFloat minPrice = [[price valueForKeyPath:@"@min.floatValue"] floatValue];
            int maxSection = (maxPrice/10);
            int minSection = (minPrice/10);
            int maxPriceSection = maxSection*10+10;
            int minPriceSection = minSection*10;
            NSLog(@"%f---%f",maxPrice,minPrice);
            
            NSMutableArray *xArray = [NSMutableArray array];
            NSMutableArray *yArrays = [NSMutableArray array];
            NSMutableArray *yArray0 = [NSMutableArray array];
            NSMutableArray *yArray1 = [NSMutableArray array];
            
            [self.firstDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [xArray addObject:obj[@"historyDate"]];
                [yArray0 addObject:obj[@"closePrice"]];
            }];
            
            [self.secondDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [xArray addObject:obj[@"historyDate"]];
                [yArray1 addObject:obj[@"closePrice"]];
            }];
            
            [yArrays addObject:yArray1];
            [yArrays addObject:yArray0];
            
            
            
       
            [self.lineChartView removeFromSuperview];
            self.lineChartView = nil;
            WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indexView.frame), UIScreenW, 180) xTitleArray:xArray yValueArray:yArrays yMax:maxPriceSection yMin:minPriceSection];
            self.lineChartView = wsLine;
            wsLine.delegate = self;
            [self.view addSubview:wsLine];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(CGSize)methodForitleItemLengths:(NSString*)titleStr{
    CGSize titleSize = [titleStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return titleSize;
}

-(void)dealloc{
    NSLog(@"%@",self);
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
