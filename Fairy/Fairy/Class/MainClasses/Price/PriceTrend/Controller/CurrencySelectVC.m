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

#define margin 7
#define space 18

@implementation CurrencySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =[UIColor colorWithHex:@"#e9eff8"];
    [self initNavtionBar];
    
    UILabel *hintLab =[UILabel new];
    hintLab.text= @"最多只能选择两个币种进行对比";
    hintLab.textColor = [UIColor colorWithHex:@"#828587"];
    hintLab.font =AdaptedFontSize(25);
    [self.view addSubview:hintLab];
    hintLab.frame = CGRectMake(AdaptedWidth(24), AdaptedWidth(24), UIScreenW-AdaptedWidth(48), AdaptedWidth(40));
    
    [self creatBtnView];
    
    // Do any additional setup after loading the view.
}

-(void)initNavtionBar{
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    ItemLab.text = @"币种选择";
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    
    UIButton *personalCenter = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [personalCenter setImage:[UIImage imageNamed:@"navBar_back"] forState:UIControlStateNormal];
    [personalCenter addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:personalCenter];
    
    UIButton *finish = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    finish.titleLabel.font = [UIFont systemFontOfSize:16];
    [finish addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:finish];
    
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)finishClick{

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
            [btn setBackgroundColor:[UIColor colorWithHex:@"#828587"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor blueColor] forState:UIControlStateSelected];
            btn.layer.borderColor = [UIColor grayColor].CGColor;
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
