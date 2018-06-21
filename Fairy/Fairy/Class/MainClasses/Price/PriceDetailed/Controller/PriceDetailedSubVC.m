//
//  PriceDetailedSubVC.m
//  Fairy
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "PriceDetailedSubVC.h"
#import "BezierLineView.h"



@interface PriceDetailedSubVC ()
@property (nonatomic,strong) NSString *currentType;
@property (strong,nonatomic)BezierLineView *bezierView;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;
@property (strong,nonatomic)NSMutableArray *y_names;


@end

@implementation PriceDetailedSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    //@"币地址检测",@"交易量预警",@"换手量预警",@"分析",@"币地址检测",@"交易量预警",@"换手量预警",@"分析",
    if ([self.headType isEqualToString:@"币地址检测"]) {
        
    }
    else if ([self.headType isEqualToString:@"交易量预警"]){
        
    }
    else if ([self.headType isEqualToString:@"换手量预警"]){
        
    }
    else if ([self.headType isEqualToString:@"分析"]){
        
    }
    else if ([self.headType isEqualToString:@"币地址检测"]){
        
    }
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.headType);
}
-(void)creatTextView{
    UILabel *textLab =[UILabel new];
    textLab.text = @"打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！打到小日本，解放全中国！！！";
    [self.view addSubview:textLab];
    textLab.numberOfLines = 0 ;
    textLab.textColor =[UIColor blackColor];
    textLab.font = AdaptedFontSize(32);
    CGSize  titleSize = [textLab.text  boundingRectWithSize: CGSizeMake(UIScreenW - 24, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin  attributes: @{NSFontAttributeName: AdaptedFontSize(32)} context: nil].size;
    textLab.frame = CGRectMake(12, 20, titleSize.width, titleSize.height);
}

-(void)loadMainTableData:(NSString *)type isPull:(BOOL)isPull{
    self.currentType = type;
    NSLog(@"%@",type);
    
    //1.初始化
    _bezierView = [[BezierLineView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, 250)];
    [self.view addSubview:_bezierView];
    
    //直线
    [_bezierView drawLineChartViewWithX_Value_Names:self.x_names Y_Value_Names:self.y_names TargetValues:self.targets LineType:LineType_Straight];
    
}


/**
 *  X轴值
 */
-(NSMutableArray *)x_names{
    if (!_x_names) {
        _x_names = [NSMutableArray arrayWithArray:@[@"1/6",@"2/6",@"3/6",@"4/6",@"5/6",@"6/6",@"7/6"]];
    }
    return _x_names;
}
/**
 *  y轴值
 */
-(NSMutableArray *)y_names{
    if (!_y_names) {
        _y_names = [NSMutableArray arrayWithArray:@[@"-2",@"0",@"2",@"4",@"6"]];
    }
    return _y_names;
}


/**
 *  Y轴值
 */
-(NSMutableArray *)targets{
    if (!_targets) {
        _targets = [NSMutableArray arrayWithArray:@[@1,@-2,@2,@5,@3,@2,@0]];
    }
    return _targets;
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
