//
//  AppDelegate.m
//  Fairy
//
//  Created by  on 2018/6/9.
//  Copyright © 2018年 . All rights reserved.
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
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "welcomeViewController.h"

#define USHARE_APPKEY  @"5b49a9398f4a9d5be4000132"

@interface AppDelegate ()<ReachabilityDelegate>

@end

@implementation AppDelegate

//应用简介：让多数人掌握数字资产投资知识
//应用介绍：币精灵（fairycoin） 通过直观图表展示、通俗易懂的指标描述，降低了投资分析的知识、技术门槛，让多数人更快掌握数字资产投资的相关知识

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[MonitorNetwork defultMonitor] DealF];//监控网络
    [MonitorNetwork defultMonitor].delegate = self;
    [self configureBoardManager]; // 键盘统一监听处理
    
    //友盟注册
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [UMConfigure initWithAppkey:USHARE_APPKEY channel:@"App Store"];
    [self configUSharePlatforms];
    
    
    [self userDataPersistence];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isfirest = [defaults boolForKey:(@"isfirst")];
    if (!isfirest) {
        
        //保存BOOL
        [defaults setBool:YES forKey:(@"isfirst")];
        //立即保存
        [defaults synchronize];
        
        welcomeViewController *vc=[welcomeViewController new];
        self.window.rootViewController = vc;
        
    }else{
        
        MainTabBarController *homeVC=[MainTabBarController new];
        self.window.rootViewController = homeVC;
        
    }
    
    // Override point for customization after application launch.
    return YES;
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx5bce4b9576c82915" appSecret:@"1fe3910681a86c22a7c4852f3fca8203" redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1107475694"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2492988176"  appSecret:@"a64c95b851f3448794553b37e289fa82" redirectURL:@"http://www.sharesdk.cn"];
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
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
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

//用户信息本地持久化
-(void)userDataPersistence{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(1) forKey:@"tradePlatformID"];
    [defaults setObject:@"Bitfinex" forKey:@"platformCnName"];
    [defaults synchronize];
}


@end
