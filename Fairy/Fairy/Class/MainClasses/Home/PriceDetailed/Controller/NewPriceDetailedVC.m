//
//  NewPriceDetailedVC.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "NewPriceDetailedVC.h"
#import "PriceIntroVc.h"
#import "PriceDataVc.h"
#import "PriceOtherVc.h"

@interface NewPriceDetailedVC ()

@end

@implementation NewPriceDetailedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initNavtionBar];
    // Do any additional setup after loading the view.
    
    PriceIntroVc *vc1 = [[PriceIntroVc alloc] init];
    
    PriceDataVc *vc2 = [[PriceDataVc alloc] init];
    
    PriceOtherVc *vc3 = [[PriceOtherVc alloc] init];

    PriceOtherVc *vc4 = [[PriceOtherVc alloc] init];

    PriceOtherVc *vc5 = [[PriceOtherVc alloc] init];

    
    
    vc1.title = @"简介";
    
    vc2.title = @"数据";
    
    vc3.title = @"资金";
    
    vc4.title = @"资金";

    vc5.title = @"资金";

    
    
    self.viewControllers = @[vc1, vc2, vc3 , vc4 , vc5 ];

    
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
    
    //    UIButton *search = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 30, 40)];
    //    [search setImage:[UIImage imageNamed:@"searchLogo"] forState:UIControlStateNormal];
    //    [search addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:search];
    
}

-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
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
