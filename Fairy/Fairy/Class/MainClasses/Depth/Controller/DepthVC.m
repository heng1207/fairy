//
//  DepthVC.m
//  Fairy
//
//  Created by 张恒 on 2018/8/25.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "DepthVC.h"

@interface DepthVC ()

@end

@implementation DepthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self initNavtionBar];
    
    // Do any additional setup after loading the view.
}

-(void)initNavtionBar{
    UILabel *ItemLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    ItemLab.text = @"深度";
    ItemLab.textAlignment = NSTextAlignmentCenter;
    ItemLab.textColor=[UIColor whiteColor];
    ItemLab.font = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = ItemLab;
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
