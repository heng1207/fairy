//
//  MainNavigationController.m
//  Fairy
//
//  Created by 张恒 on 2018/6/10.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import "MainNavigationController.h"




@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar_background"]forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];//隐藏灰线条
    NSLog(@"%f----%f",self.navigationBar.frame.size.height,self.navigationBar.frame.size.width);
    
    //    self.navigationBar.barTintColor=[UIColor blueColor]; //导航栏背景颜色
    //    self.navigationBar.tintColor = [UIColor redColor]; //导航栏字体颜色(返回按钮)
    

    
    // Do any additional setup after loading the view.
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
