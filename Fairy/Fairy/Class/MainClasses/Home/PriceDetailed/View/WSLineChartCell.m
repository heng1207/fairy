//
//  WSLineChartCell.m
//  Fairy
//
//  Created by 张恒 on 2018/8/25.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "WSLineChartCell.h"
#import "WSLineChartView.h"


@interface  WSLineChartCell()
@property(nonatomic,strong)WSLineChartView *wsLine;

@property(nonatomic,strong)UILabel *titleLab;

@end


@implementation WSLineChartCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

    }
    return self;
}


-(void)setFirstDataArr:(NSMutableArray *)firstDataArr{
    _firstDataArr = firstDataArr;
    
    
    //获取显示区间最大值，最小值
    NSMutableArray *price = [NSMutableArray array];
    for (NSDictionary *item in firstDataArr ) {
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
    NSMutableArray *yArray = [NSMutableArray array];
    [firstDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [xArray addObject:obj[@"historyDate"]];
        [yArray addObject:obj[@"closePrice"]];
    }];
    if (self.wsLine) {
        [self.wsLine removeFromSuperview];
        self.wsLine = nil;
    }
    WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(12, 0, UIScreenW-12, 130) xTitleArray:xArray yValueArray:yArray yMax:maxPriceSection yMin:minPriceSection];
    self.wsLine = wsLine;
    [self.contentView addSubview:wsLine];
    
}
//
//-(void)setSecondDataArr:(NSMutableArray *)secondDataArr{
//    _secondDataArr = secondDataArr;
//    if (secondDataArr.count>0) {
//        
//        UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 15, self.width, 17)];
//        titleLab.textAlignment = NSTextAlignmentCenter;
//        titleLab.text =@"某某某折线图";
//        titleLab.font = [UIFont systemFontOfSize:15];
//        [self.contentView addSubview:titleLab];
//        
//        SegmentView *segView=[[SegmentView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 22)];
//        segView.tag = 22;
//        [self.contentView addSubview:segView];
//
//        
//
//        //获取显示区间最大值，最小值
//        NSMutableArray *price = [NSMutableArray array];
//        for (NSDictionary *item in secondDataArr) {
//            [price addObject: [NSNumber numberWithFloat:[item[@"closePrice"] floatValue]]];
//        }
//        CGFloat maxPrice = [[price valueForKeyPath:@"@max.floatValue"] floatValue];
//        CGFloat minPrice = [[price valueForKeyPath:@"@min.floatValue"] floatValue];
//        int maxSection = (maxPrice/10);
//        int minSection = (minPrice/10);
//        int maxPriceSection = maxSection*10+10;
//        int minPriceSection = minSection*10;
//        //            NSLog(@"%f---%f",maxPrice,minPrice);
//        
//        NSMutableArray *xArray = [NSMutableArray array];
//        NSMutableArray *yArray = [NSMutableArray array];
//        [secondDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [xArray addObject:obj[@"historyDate"]];
//            [yArray addObject:obj[@"closePrice"]];
//        }];
//        
//        WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, 75, UIScreenW, 120) xTitleArray:xArray yValueArray:yArray yMax:maxPriceSection yMin:minPriceSection];
//        
//        [self.contentView addSubview:wsLine];
//        
//    }
//}



//-(void)creatSubView{
//    //获取显示区间最大值，最小值
//    NSMutableArray *price = [NSMutableArray array];
//    for (NSDictionary *item in obj[@"data"] ) {
//        [price addObject: [NSNumber numberWithFloat:[item[@"closePrice"] floatValue]]];
//    }
//    CGFloat maxPrice = [[price valueForKeyPath:@"@max.floatValue"] floatValue];
//    CGFloat minPrice = [[price valueForKeyPath:@"@min.floatValue"] floatValue];
//    int maxSection = (maxPrice/10);
//    int minSection = (minPrice/10);
//    int maxPriceSection = maxSection*10+10;
//    int minPriceSection = minSection*10;
//    //            NSLog(@"%f---%f",maxPrice,minPrice);
//
//    NSMutableArray *xArray = [NSMutableArray array];
//    NSMutableArray *yArrays = [NSMutableArray array];
//    NSMutableArray *yArray0 = [NSMutableArray array];
//    [obj[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [xArray addObject:obj[@"historyDate"]];
//        [yArray0 addObject:obj[@"closePrice"]];
//    }];
//    [yArrays addObject:yArray0];
//
//    WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.indexView.frame), UIScreenW, 180) xTitleArray:xArray yValueArray:yArrays yMax:maxPriceSection yMin:minPriceSection];
//    self.lineChartView = wsLine;
//    wsLine.delegate = self;
//    [self.view addSubview:wsLine];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
