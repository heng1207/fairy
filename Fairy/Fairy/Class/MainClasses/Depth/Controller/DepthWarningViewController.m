
//
//  DepthWarningViewController.m
//  Fairy
//
//  Created by Maybe Sku on 2018/9/3.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "DepthWarningViewController.h"
#import "DepthWaringDetailVC.h"
#import "DepthWaringDetailNewVC.h"
#import "DepthWaringDetailGoogleVC.h"

@interface DepthWarningViewController ()

@end

@implementation DepthWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavtionBar];
    // Do any additional setup after loading the view.
    
    DepthWaringDetailGoogleVC *vc1 = [[DepthWaringDetailGoogleVC alloc] init];
    DepthWaringDetailVC *vc2 = [[DepthWaringDetailVC alloc] init];
    DepthWaringDetailNewVC *vc3 = [[DepthWaringDetailNewVC alloc] init];

    vc1.title = @"相关性";
    vc2.title = @"预测";
    vc3.title = @"新闻";
    
    self.viewControllers = @[vc1, vc2, vc3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavtionBar{
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    ItemLab.text = @"预警中心";
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
