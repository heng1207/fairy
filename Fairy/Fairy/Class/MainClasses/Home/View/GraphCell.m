//
//  GraphCell.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "GraphCell.h"
#import "BezierCurveView.h"

@interface GraphCell()

@property (strong,nonatomic)BezierCurveView *bezierView;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;

@end

@implementation GraphCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self creatSubView];
    }
    return self;
}

-(void)creatSubView{
    
    //1.初始化
    _bezierView = [BezierCurveView initWithFrame:CGRectMake(0, 7, UIScreenW, 133)];
    NSLog(@"%f--%f",self.frame.size.width,self.frame.size.height);
//    _bezierView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_bezierView];
    
    //2曲线
    [_bezierView drawLineChartViewWithX_Value_Names:self.x_names TargetValues:self.targets LineType:LineType_Curve];
    
}
/**
 *  X轴值
 */
-(NSMutableArray *)x_names{
    if (!_x_names) {
        _x_names = [NSMutableArray arrayWithArray:@[@"2018-05-13",@"9:00",@"12:00",@"15:00",@"18:00",@"21:00",@"0:00"]];
    }
    return _x_names;
}
/**
 *  Y轴值
 */
-(NSMutableArray *)targets{
    if (!_targets) {
        _targets = [NSMutableArray arrayWithArray:@[@[@20,@40,@20,@50,@30,@60,@30],@[@30,@50,@30,@60,@40,@70,@40],@[@40,@60,@40,@70,@50,@80,@50]]];
    }
    return _targets;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
