//
//  HTTPRequestDefine.h
//  zhcxuser
//
//  Created by  on 2017/9/11.
//  Copyright © 2017年 . All rights reserved.
//

#ifndef HTTPRequestDefine_h
#define HTTPRequestDefine_h

// http://47.75.145.77:8080/interface/swagger-ui.html#/  接口测试链接

//#define SERVER        @"http://47.75.145.77:8080/interface"
#define SERVER        @"http://47.254.69.147:8080/interface"



/*
 登陆注册
 */
// 注册，获取短信验证码
#define GetLoginMessage(phone)   ([NSString stringWithFormat:@"%@/front/get_check_code/%@",SERVER,phone])
//注册
#define Register                 (SERVER@"/consumer/insert")
// 用户名登录
#define UserNameLogin            (SERVER@"/login")
// 验证码登录
#define CodeLogin                (SERVER@"/login_by_checkcode")
// 修改密码
#define UpdatePassword           (SERVER@"/student_account/update_password")
// 忘记密码，获取短信验证码
#define GetForgetPasswordMessage(phone)   ([NSString stringWithFormat:@"%@/front/get_forget_password_check_code/%@",SERVER,phone])
// 用验证码重置密码
#define setPassword               (SERVER@"/front/reset_forget_password")
// 退出
#define logOut                    (SERVER@"/logout")
// 上传头像
#define uploadPhoto               (SERVER@"/upload_header_portrait")
// 用户信息查看
#define consumerView               (SERVER@"/consumer/view")
// 用户信息新增
#define consumerInsert               (SERVER@"/consumer/insert")
// 用户信息修改
#define consumerUpdate               (SERVER@"/consumer/update")




// 交易平台查询
#define tradingPlatform           (SERVER@"/trade_platform/list_data")
// 数字货币查询
#define digitalCash               (SERVER@"/digital_currency/list_data")
// 全球指数
#define globalIndex               (SERVER@"/global_index/list_data")
// 首页tab分类
#define moneyClass                (SERVER@"/dictionary/list_currency_type")
// 首页tab分类内容
#define moneyClassContent         (SERVER@"/coin_pair/list_data")
//自选查看
#define optionalView              (SERVER@"/consumer_pair/view")
//加入自选
#define optionalInsert            (SERVER@"/consumer_pair/insert")
//删除自选
#define optionalDelete            (SERVER@"/consumer_pair/delete")



//http://47.254.69.147:8080/interface/coin_pair/list_data?pageNo=1&pageSize=10
//币种选择
#define moneyTypeSelect           (SERVER@"/coin_pair/list_data")
//行情详情折线图
#define coinmarketcapHistory      (SERVER@"/coinmarketcap/getCoinmarketcapHistoryData")
//http://47.75.145.77:8080/interface/coinmarketcap/getCoinmarketcapHistoryData?coinPair=eth

//行情分析-介绍
#define PriceIntroduce            (SERVER@"/digital_currency/viewByshortEnName/")

//行情分析
#define PriceAnalyze              (SERVER@"/statistics/search")
//http://47.75.145.77:8080/interface/statistics/search?coin=btc&type=googlevscoin

//行情预测
#define PriceForecast             (SERVER@"/predict/search/")


//K线图
//http://47.254.69.147:8080/interface/kline/get_kline_15m?tradePlatform=bitfinex&coinPair=eth_btc&klineDate=20180801

//价格趋势图
#define PriceTrendChart           (SERVER@"/kline/getPriceListData")
//http://47.75.145.77:8080/interface/kline/getKPriceListData?tradePlatform=bitfinex&coinPair=eth_btc

//交易量趋势图
#define VolumeTrendChart          (SERVER@"/kline/getVolumeListData")
//http://47.75.145.77:8080/interface/kline/getKVolumeListData?tradePlatform=bitfinex&coinPair=eth_btc

//资讯
#define Information                (SERVER@"/news/list_data")
//http://47.75.145.77:8080/interface/news/list_data?lang=cn


//钱包打开页面
#define GetAmountInfo              (SERVER@"/wallet/getAmountInfo")

//钱包判断是否有支付密码
#define HasPayPassword              (SERVER@"/wallet/hasPayPassword")

//忘记或重置支付密码
#define ResetForgetPayPassword              (SERVER@"/wallet/resetForgetPayPassword")


//获取验证码
#define GetCheckCode              (SERVER@"/wallet/getCheckCode")

//获取交易记录
#define GetTradeHistory              (SERVER@"/wallet/getTradeHistory")


//钱包判断是否有支付密码
#define WalletRecharge              (SERVER@"/wallet/recharge")

//设置支付密码
#define setPayPassword              (SERVER@"/wallet/setPayPassword")

//验证支付密码
#define verifyPayPassword              (SERVER@"/wallet/verifyPayPassword")

//提币
#define sendToAddress              (SERVER@"/wallet/sendToAddress")

//当天该币交易量排行查询
#define SelectNowList              (SERVER@"/tranOcRatio/selectNowList")

//当天该币种饼图数据查询
#define SelectPie              (SERVER@"/tranOcRatio/selectPie")

//当天该币种饼图数据查询
#define GetTradeHistory              (SERVER@"/wallet/getTradeHistory")



#endif /* HTTPRequestDefine_h */
