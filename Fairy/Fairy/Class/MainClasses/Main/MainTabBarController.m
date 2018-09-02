//
//  MainTabBarController.m
//  Fairy
//
//  Created by  on 2018/6/10.
//  Copyright © 2018年 . All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "HomeVC.h"
#import "DepthVC.h"
#import "InformationVC.h"
#import "MineVC.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setActivityViewControllers];
    
    // Do any additional setup after loading the view.
}

- (void)setActivityViewControllers
{
    HomeVC *homeVC = [[HomeVC alloc]init];
    [self setupOneChildViewController:homeVC title:@"行情" image:@"icon_quotes_default" selectedImage:@"icon_quotes_select"];

    DepthVC *depthVC = [[DepthVC alloc]init];
    [self setupOneChildViewController:depthVC title:@"深度" image:@"icon_depth_default" selectedImage:@"icon_depth_select"];

    InformationVC * informationVC = [[InformationVC alloc]init];
    [self setupOneChildViewController:informationVC title:@"资讯" image:@"icon_information_default" selectedImage:@"icon_information_select"];

    MineVC * mineVC = [[MineVC alloc]init];
    [self setupOneChildViewController:mineVC title:@"我的" image:@"icon_mine_default" selectedImage:@"icon_mine_select"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
//    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#"]} forState:UIControlStateNormal];
//    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[ColorRoot hexStringToColor:@"#fde712"]} forState:UIControlStateSelected];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
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
