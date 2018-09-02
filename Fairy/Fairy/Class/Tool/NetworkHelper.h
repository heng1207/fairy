//
//  NetworkHelper.h
//  QTX
//
//  Created by mac on 16/7/22.
//  Copyright © 2016年 zhangbing. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void( ^ BCResponseSuccess)(id response);
typedef void( ^ BCPResponseFail)(NSError *error);

@interface NetworkHelper : NSObject
+(void)NewGetDataWithUrl:(NSString *)url params:(NSDictionary *)params Success:(BCResponseSuccess)success Fail:(BCPResponseFail)fail;


+(void)NewPostDataWithUrl:(NSString *)url params:(NSDictionary *)params Success:(BCResponseSuccess)success Fail:(BCPResponseFail)fail;


@end
