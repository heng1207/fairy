//
//  GraphCell.m
//  Fairy
//
//  Created by  on 2018/6/15.
//  Copyright © 2018年 . All rights reserved.
//

#import "GraphCell.h"
#import "IndexTypeView.h"
#import "BezierView.h"
#import "CurveLineChartView.h"

@interface GraphCell()

@property (strong,nonatomic)BezierView *bezierView;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *y_names;
@property (strong,nonatomic)NSMutableArray *targets;

@property (strong,nonatomic)CurveLineChartView *wsLine;
@end

@implementation GraphCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"#e8f0f3"];
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    
    IndexTypeView *typeView = [[IndexTypeView alloc]initWithFrame:CGRectMake(0, 7, UIScreenW, 20)];
    [self.contentView addSubview:typeView];
    

    //1.初始化
    _bezierView = [[BezierView alloc]initWithFrame:CGRectMake(0, 27, UIScreenW, 113) WithX_Value_Names:self.x_names Y_Value_Names:self.y_names TargetValues:self.targets Type:Type_quxian];
    _bezierView.backgroundColor =[UIColor whiteColor];
    [self.contentView addSubview:_bezierView];
    
    
    
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

/**
 *  X轴值
 */
-(NSMutableArray *)x_names{
    if (!_x_names) {
        _x_names = [NSMutableArray arrayWithArray:@[@"3:00",@"6:00",@"9:00",@"12:00",@"15:00",@"18:00",@"21:00",@"00:00"]];
    }
    return _x_names;
}
/**
 *  y轴值
 */
-(NSMutableArray *)y_names{
    if (!_y_names) {
        _y_names = [NSMutableArray arrayWithArray:@[@"200",@"400",@"600",@"800",@"1000",@"1200",]];
    }
    return _y_names;
}
/**
 *  targets值
 */
-(NSMutableArray *)targets{
    if (!_targets) {
        _targets = [NSMutableArray arrayWithArray:@[@[@200,@1200,@800,@400,@200,@700,@1200,@300],@[@300,@400,@450,@230,@880,@330,@600,@350],@[@500,@550,@700,@750,@800,@200,@900,@700]]];
        
//        _targets = [NSMutableArray arrayWithArray:@[@200,@1200,@800,@400,@200,@700,@1200,@300]];
    }
    return _targets;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
