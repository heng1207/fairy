//
//  GlobConfig.h
//  
//
//  Created by Maybe Sku on 2018/8/27.
//  Copyright © 2018年 张恒. All rights reserved.
//

#ifndef GlobConfig_h
#define GlobConfig_h

#define APP_ID @"1106710782"

//appinfo
#define kRegisteAgreement       @"registeAgreement"     //注册协议
#define kIntroduce              @"introduce"            //寻我介绍
#define kOfficialWebsite        @"officialWebsite"      //官方网址
#define kSinaMicroblog          @"sinaMicroblog"        //新浪微博
#define kCustomerServertel      @"customerServertel"    //客服电话
#define kCharges                @"charges"              //收费标准
#define kAdvertisingAgreement   @"advertisingAgreement" //广告协议

#define kUserRole @"role"   //用户角色
#define kAddress  @"address"
#define kAddressModel    @"addressModel"

#define kDoctor  @"doctor"

#define kMyJobTitle   @"jobTitle";
#define kMyIntroduction  @"introduction"
#define kMyHospitalId   @"hospitalId"

#define kToken @"token"
#define kHuanXinID  @"huanxinId"
#define kUser  @"user"
#define kPhoneNumber @"phoneNumber"

#define kAssignTo @"assignTo"


#define kStaffRole @"personnelType"
#define kStaffSex @"sex"
#define kStaffRealname @"realname"
#define kStaffNum @"workNumber"

#define kHospitalLevel    @"HospitalLevel"
#define kDoctorWork       @"DoctorWork"




#define kLocalAdversingModel   @"localAdversing"
#define kLocalSpecialModel  @"localSpecial"
#define kLocalHobbyModel   @"localHobby"

#define kLongitude  @"longitude"
#define kLatitude   @"latitude"

#define kFirstAppLaunch         @"ks_first_3.0.0"

#define KurgentInfo         @"urgentInfo"


//判断设备的屏幕尺寸
#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_SCREEN_47_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_SCREEN_55_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONEX      ((int)DEVICE_HEIGHT % 812 == 0)


//判定系统版本号
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)

#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending)

#define IOS8VERSION    [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define IOS7VERSION    [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define kScreenBounds   [[UIScreen mainScreen]bounds]
#define kScreenWidth    [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight   [[UIScreen mainScreen]bounds].size.height
#define kScreenScale    (kScreenWidth/320.0f)
#define kScreenValue(value) ((value)/375.0f*[UIScreen mainScreen].bounds.size.width)

#define kWidthScale     (kScreenWidth/375.0f)
#define kHeightScale    (kScreenHeight/667.0f)

#define kTopHeight(value1,value2)  (kScreenHeight == 812.0 ? value1 : value2)


#define StatusBarHeight (kScreenHeight == 812.0 ? 44 : 20)

#define NavBarHeight    44
#define SafeAreaTopHeight (kScreenHeight == 812.0 ? 88 : 64)
#define SafeAreaBottomHeight (kScreenHeight == 812.0 ? 34 : 0)
#define EmptyViewY (kScreenHeight == 812.0 ? 0 : 20)

#define SafeAreaHeightWithNav kScreenHeight - SafeAreaTopHeight - SafeAreaBottomHeight
#define TabBarHeight        49

/// 第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}



#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define kFileManager        [NSFileManager defaultManager]

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
//颜色和透明度设置
#define RGBA(r,g,b,a) [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define WS(wSelf)            __weak typeof(self) wSelf = self
#define SS(sSelf)            __strong typeof(wSelf) sSelf = wSelf

#define  IMG(x)             [UIImage imageNamed:x]

#endif /* GlobConfig_h */
