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
@property (strong,nonatomic)IndexTypeView *typeView;
@property (strong,nonatomic)CurveLineChartView *wsLine;
@end

@implementation GraphCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"#e8f0f3"];
        
        IndexTypeView *typeView = [[IndexTypeView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 25)];
        self.typeView = typeView;
        [self.contentView addSubview:typeView];
        
    }
    return self;
}

-(void)setDataDic:(NSMutableDictionary *)dataDic{
    _dataDic = dataDic;
    
    self.typeView.selectType = dataDic[@"selectType"];
    
    
    if (self.wsLine) {
        [self.wsLine removeFromSuperview];
        self.wsLine = nil;
    }
    NSString *maxStr = dataDic[@"max"];
    NSString *minStr = dataDic[@"min"];
    
    UIColor *lineColor;
    if ([dataDic[@"selectType"] isEqualToString:@"btc"]) {
        lineColor = [UIColor redColor];
    }
    else if ([dataDic[@"selectType"] isEqualToString:@"bch"]){
        lineColor = [UIColor greenColor];
    }
    else{
        lineColor = [UIColor blueColor];
    }
    
    CurveLineChartView *wsLine = [[CurveLineChartView alloc]initWithFrame:CGRectMake(0, 25, UIScreenW, 145) xTitleArray:dataDic[@"xArray"] yValueArray:dataDic[@"targetArray"] yMax:[maxStr floatValue] yMin:[minStr floatValue] LineColor:lineColor];
    self.wsLine =wsLine;
    [self.contentView addSubview:wsLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
