
//
//  SuperFastLineController.m
//  Fairy
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "SuperFastLineController.h"
#import "SuperFastLineDetailVC.h"
@interface SuperFastLineController ()

@end

@implementation SuperFastLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavtionBar];
    // Do any additional setup after loading the view.
    
    SuperFastLineDetailVC *vc1 = [[SuperFastLineDetailVC alloc] init];
    SuperFastLineDetailVC *vc2 = [[SuperFastLineDetailVC alloc] init];
    SuperFastLineDetailVC *vc3 = [[SuperFastLineDetailVC alloc] init];
    SuperFastLineDetailVC *vc4 = [[SuperFastLineDetailVC alloc] init];
    
    vc1.title = @"BTC";
    vc2.title = @"ETH";
    vc3.title = @"BCH";
    vc4.title = @"LTC";
 
    self.viewControllers = @[vc1, vc2, vc3 , vc4 ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavtionBar{
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    ItemLab.text = @"超短线助手";
    ItemLab.textAlignment = NSTextAlignmentCenter;
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
