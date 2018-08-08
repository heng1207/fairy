//
//  GraphCell.m
//  Fairy
//
//  Created by  on 2018/6/15.
//  Copyright © 2018年 . All rights reserved.
//

#import "GraphCell.h"
#import "IndexTypeView.h"
#import "CurveLineChartView.h"

@interface GraphCell()

@property (strong,nonatomic)CurveLineChartView *wsLine;
@end

@implementation GraphCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"#e8f0f3"];
        
        IndexTypeView *typeView = [[IndexTypeView alloc]initWithFrame:CGRectMake(0, 7, UIScreenW, 20)];
        [self.contentView addSubview:typeView];
        
    }
    return self;
}

-(void)setDataDic:(NSMutableDictionary *)dataDic{
    _dataDic = dataDic;
    
    if (self.wsLine) {
        [self.wsLine removeFromSuperview];
        self.wsLine = nil;
    }
    NSString *maxStr = dataDic[@"max"];
    NSString *minStr = dataDic[@"min"];
    CurveLineChartView *wsLine = [[CurveLineChartView alloc]initWithFrame:CGRectMake(0, 27, UIScreenW, 113) xTitleArray:dataDic[@"xArray"] yValueArray:dataDic[@"targetArray"] yMax:[maxStr floatValue] yMin:[minStr floatValue]];
    self.wsLine =wsLine;
    [self.contentView addSubview:wsLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
