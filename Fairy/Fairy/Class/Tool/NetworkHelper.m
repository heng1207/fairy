//
//  NetworkHelper.m
//  QTX
//
//  Created by mac on 16/7/22.
//  Copyright © 2016年 zhangbing. All rights reserved.
//

#import "NetworkHelper.h"

#define APP_WIN [[[UIApplication sharedApplication] delegate] window]

@implementation NetworkHelper



/**
 新post请求

 @param url     Url
 @param params  入参
 @param success 成功
 @param fail    失败
 */
+(void)NewGetDataWithUrl:(NSString *)url params:(NSDictionary *)params Success:(BCResponseSuccess)success Fail:(BCPResponseFail)fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer.timeoutInterval = 200.f;
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain",nil];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    [manager.requestSerializer setValue:@"178trip" forHTTPHeaderField:@"Referer"];
    //    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain",nil];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            
            fail(error);
        }
    }];
  
}


+(void)NewPostDataWithUrl:(NSString *)url params:(NSDictionary *)params Success:(BCResponseSuccess)success Fail:(BCPResponseFail)fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer.timeoutInterval = 200.f;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain",nil];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"178trip" forHTTPHeaderField:@"Referer"];
//    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain",nil];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;

    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(responseObject);
         }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
           
            fail(error);
        }
    }];
    

    
}

-(void)changeVCWithViewController:(UIViewController*)vc
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:5 forView:APP_WIN cache:YES];
    [UIView commitAnimations];
    APP_WIN.rootViewController = vc;
}


@end
