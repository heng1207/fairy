//
//  PhoneZhuCeModel.h
//  Fairy
//
//  Created by mac on 2018/6/14.
//  Copyright © 2018年 张恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneZhuCeModel : NSObject<NSCoding>

// 用户唯一UID
@property (nonatomic, strong) NSString *userId;
// 自动登录密码
@property (nonatomic, strong) NSString *autoKey;
// 登录手机号码
@property (nonatomic, strong) NSString *mobile;
// 盐
@property (nonatomic, strong) NSString *salt;
// 自己设置的登录密码
@property (nonatomic, strong) NSString *pwd;
//头像
@property (nonatomic,strong)  NSString *profile;



@end
