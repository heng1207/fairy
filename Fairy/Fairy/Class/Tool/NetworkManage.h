//
//  NetworkManage.h
//  zhcxuser
//
//  Created by orilme on 2017/9/11.
//  Copyright © 2017年 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Reachability.h"

@interface NetworkManage : NSObject

@property(nonatomic,strong)Reachability* reach;

//http请求
+(AFHTTPSessionManager* )instance;
+ (void)Post:(NSString *)Path andParams:(NSMutableDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)Get:(NSString *)Path andParams:(NSMutableDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)Put:(NSString *)path andParams:(NSMutableDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)Post:(NSString *)path andParams:(NSMutableDictionary *)dic andPhotoArr:(NSMutableArray*)photoArr success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


@end
