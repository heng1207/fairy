//
//  HTTPRequestDefine.h
//  zhcxuser
//
//  Created by orilme on 2017/9/11.
//  Copyright © 2017年 orilme. All rights reserved.
//

#ifndef HTTPRequestDefine_h
#define HTTPRequestDefine_h

// http://47.75.145.77:8080/interface/swagger-ui.html#/  接口测试

#define SERVER        @"http://47.75.145.77:8080/interface"

/*
 登陆
 */
#define GetLoginMessage(phone)   ([NSString stringWithFormat:@"http://47.75.145.77:8080/interface/front/get_check_code/%@",phone])       // 获取短信验证码

#define VersionTest              (SERVER@"/vers/version")                        // 版本验证
#define LoginMode                (SERVER@"/user/loginMode")                      // 登录方式
#define PassWordLogin            (SERVER@"/user/pwdLogin")                       // 密码登录接口
#define AutoLogin                (SERVER@"/user/autoLogin")                      // 自动登录接口
#define CodeLogin                (SERVER@"/user/codeLogin")                      // 验证码登录接口
#define checkCode                (SERVER@"/user/chkVerificationCode/")           // 检测 验证码
#define logOut                   (SERVER@"/user/logOut")                         // 退出
#define invite                   (SERVER@"/invitation/recommend")                         // 邀请
#define inviteReward             (SERVER@"/invitation/view")//查看获得到的奖励

/*
 个人信息
 */
#define userinfo                 (SERVER@"/userInfo/info/")                      // 用户信息
#define updateInfo               (SERVER@"/userInfo/updateInfo/")                // 修改用户信息
#define uploadPhoto              (SERVER@"/file/upload/")                        // 用上次图片
#define setNewPwd                (SERVER@"/user/setPwdByYzm/")                   // 设置新密码
#define changeMobile             (SERVER@"/user/updMobilePassenger")             // 修改手机号码
#define getMyJourney             (SERVER@"/order/getMyJourney")                  // 查询我的订单
#define getJourneyDetails        (SERVER@"/order/detail")                        // 查询订单详情
#define Wallet                   (SERVER@"/wallet/my/")                          // 查询余额
#define MoneyWithdraw            (SERVER@"/apply/saveApply")                     // 余额提现
#define lawList                  (SERVER@"/law/list")                            // 法律条款条目列表
#define ComplaintsOrsuggest      (SERVER@"/suggest/sendSuggest")                 // 投诉及建议
#define receiveCoupon            (SERVER@"/coupons/receive")                         // 领取优惠券
#define getCoupon                (SERVER@"/coupons/list")                         // 用户优惠券列表
#define WithdrawList             (SERVER@"/apply/list")                         // 提现记录列表




/*
 订单信息
 */
#define aboutTaxiPrice           (SERVER@"/taxiPrice/aboutTaxiPrice")            // 订单大约价格
#define sendOrder                (SERVER@"/order/sendOrder/")                    // 发送订单
#define cancleOrder              (SERVER@"/order/cancel/")                       // 取消订单
#define getRecDriverMsg          (SERVER@"/userInfo/getRecDriverMsg")            // 获取接单司机 信息
#define cancelReasons            (SERVER@"/order/cancelReasons")                 // 取消订单原因列表
#define getOrderPrices           (SERVER@"/order/getOrderInfoById")              // 订单真实价格
#define takingOrder              (SERVER@"/order/ifHasBizOrder")                 // 验证是否有正在进行的单
#define evaluateOrder            (SERVER@"/comment/sendComment")                 // 评价行程



// 图片路径
#define ImageURL                  @"http://192.168.1.166/image/"

#define aliPay                   (SERVER@"/ali/orderInfo")                        // 阿里支付
#define WeChatPay                (SERVER@"/wx/payOrder")                          // 微信支付



#endif /* HTTPRequestDefine_h */
