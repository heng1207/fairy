//
//  GraphCell.m
//  Fairy
//
//  Created by  on 2018/6/15.
//  Copyright © 2018年 . All rights reserved.
//

#import "GraphCell.h"
#import "CurveLineChartView.h"



@interface GraphCell()

@property (strong,nonatomic)CurveLineChartView *wsLine;

@end

@implementation GraphCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)setCurrentIndexType:(NSString *)currentIndexType{
    _currentIndexType = currentIndexType;
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
    CurveLineChartView *wsLine = [[CurveLineChartView alloc]initWithFrame:CGRectMake(12, 0, UIScreenW-12, 155) xTitleArray:xArray yValueArray:yArray yMax:maxPriceSection yMin:minPriceSection LineType:self.currentIndexType];
    self.wsLine = wsLine;
    [self.contentView addSubview:wsLine];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
