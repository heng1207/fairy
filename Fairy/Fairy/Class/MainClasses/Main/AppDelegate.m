//
//  AppDelegate.m
//  Fairy
//
//  Created by 张恒 on 2018/6/9.
//  Copyright © 2018年 张恒. All rights reserved.
//

/*
 http://47.75.145.77:8080/interface/swagger-ui.html#/  接口测试
 https://github.com/gltwy/LTScrollView  //tableView嵌套
 https://github.com/shunFSKi/FSScrollViewNestTableView   //tableView嵌套
 
 https://github.com/xiayuanquan/BezierCurveLineTest //画折线
 https://github.com/PittWong/XXChartView //折线下面有阴影
 https://github.com/niuxinhuai/LineChart //折线下面有阴影  添加圆点 (https://blog.csdn.net/super_niuxinhuai/article/details/78775281)
 
 https://github.com/MarcWeigert/GGCharts
 https://github.com/mws100/NightModeExample  //iOS夜间模式方案
 */

#import "AppDelegate.h"
#import "MainTabBarController.h"

#import "LoginVC.h"
@interface AppDelegate ()<ReachabilityDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[MonitorNetwork defultMonitor] DealF];//监控网络
    [MonitorNetwork defultMonitor].delegate = self;
    [self configureBoardManager]; // 键盘统一监听处理
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    
    
    MainTabBarController *homeVC=[MainTabBarController new];
    self.window.rootViewController = homeVC;
//    UINavigationController *nav =  [[UINavigationController alloc]initWithRootViewController:[LoginVC new]];
//    self.window.rootViewController = nav;
    
    
    // Override point for customization after application launch.
    return YES;
}
#pragma mark 键盘弹出、隐藏管理
-(void)configureBoardManager {
    // 设置键盘自动弹起
    [[IQKeyboardManager sharedManager]  setEnable:YES];
    // 是否添加键盘上的toolBar
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    // 设置键盘和输入框之间的距离
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:60];
    // 当键盘弹起时，点击背景，键盘就会收回
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    // 是否在toolBar显示输入框中的placeHoder
    [[IQKeyboardManager sharedManager] setShouldShowToolbarPlaceholder:YES];
    // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    // 设置toolBar上的颜色文字颜色是否用户自定义
    [[IQKeyboardManager sharedManager] setShouldToolbarUsesTextFieldTintColor:NO];
    // 设置toolBar上的字体内容
    [[IQKeyboardManager sharedManager] setToolbarDoneBarButtonItemText:@"完成"];
    
}

#define ReachabilityDelegate
-(void)HcltButtonDelegateAction:(int)a{
    NSLog(@"%d",a);
    if (a==1) { //有网络
  
    }else{ //没有网络
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"网络有问题"];
        [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
