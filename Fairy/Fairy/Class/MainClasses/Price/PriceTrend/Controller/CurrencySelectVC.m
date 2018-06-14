//
//  CurrencySelectVC.m
//  Fairy
//
//  Created by mac on 2018/6/12.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "CurrencySelectVC.h"

@interface CurrencySelectVC ()
@property (nonatomic,strong) NSMutableArray *flagArray;
@property(nonatomic,strong)NSMutableArray *btnArr;
@end

#define margin 6
#define space 18

@implementation CurrencySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"币种选择";
    self.view.backgroundColor =[UIColor darkGrayColor];
    
    UILabel *hintLab =[UILabel new];
    hintLab.text= @"最多只能选择两个币种进行对比";
    hintLab.textColor = [UIColor grayColor];
    hintLab.font =[UIFont systemFontOfSize:18];
    [self.view addSubview:hintLab];
    hintLab.frame = CGRectMake(AdaptedWidth(24), AdaptedWidth(24), UIScreenW-AdaptedWidth(48), AdaptedWidth(40));
    
    [self creatBtnView];
    
    // Do any additional setup after loading the view.
}

-(void)creatBtnView{
    
    float width  = (UIScreenW - 2*margin - 3*space)/4;
    float height = 45;
    
    UIView *backView=[[UIView alloc]init];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    float hangNum = ((self.flagArray.count%4)==/* DISABLES CODE */ (0)) ?(self.flagArray.count/4): ((self.flagArray.count/4)+1);
    backView.frame = CGRectMake(0,AdaptedWidth(88) ,UIScreenW, margin + hangNum*(space+height));
    
    
    self.btnArr =[NSMutableArray array];
    for (NSInteger i=0; i<self.flagArray.count; i++) {

        UIButton *btn =[UIButton new];
        btn.frame =CGRectMake(margin + (i%4)*(space+width), margin + (i/4)*(space+height), width, height);
        btn.tag=i;
        btn.selected = NO;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:self.flagArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor blueColor] forState:UIControlStateSelected];
        }else{
            [btn setBackgroundColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor blueColor] forState:UIControlStateSelected];
            btn.layer.borderColor = [UIColor blackColor].CGColor;
        }
        
        [backView addSubview:btn];
        [self.btnArr addObject:btn];
    }
    

    
    
}

-(void)selectClick:(UIButton*)btn{
    btn.selected = !btn.selected ;
}

- (NSMutableArray *)flagArray
{
    if (_flagArray == nil) {
        _flagArray = [NSMutableArray arrayWithObjects:@"自选",@"BTC",@"BCH",@"ETH",@"EOS",@"币安",@"ETC",@"LTC",@"Others", nil];
    }
    return _flagArray;
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
