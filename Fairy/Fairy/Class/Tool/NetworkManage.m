//
//  NetworkManage.m
//  zhcxuser
//
//  Created by orilme on 2017/9/11.
//  Copyright © 2017年 orilme. All rights reserved.
//

#import "NetworkManage.h" //http请求


@implementation NetworkManage


static AFHTTPSessionManager *_manager;
+(AFHTTPSessionManager *)instance{
    @synchronized (self) {
        if (_manager ==nil) {
            _manager = [AFHTTPSessionManager manager];
            //让AFN默认也支持接收text/html文件类型（AFN默认不支持接收text/html文件类型的）
            _manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
//            _manager.requestSerializer.timeoutInterval = 5;
        }
    }
    return _manager;
    
}
+ (void)Post:(NSString *)Path andParams:(NSMutableDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    [NetworkManage instance].requestSerializer  = [AFJSONRequestSerializer serializer];
    [NetworkManage instance].responseSerializer = [AFJSONResponseSerializer serializer];
    [[NetworkManage instance] POST:Path parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
    
    
    
}




+ (void)Get:(NSString *)Path andParams:(NSMutableDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    [NetworkManage instance].requestSerializer  = [AFJSONRequestSerializer serializer];
    [NetworkManage instance].responseSerializer = [AFJSONResponseSerializer serializer];
    
    [[NetworkManage instance] GET:Path parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            failure(error);
        }
        
    }];
    
    
    
    
    
}

+ (void)Put:(NSString *)path andParams:(NSMutableDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    
    [NetworkManage instance].requestSerializer  = [AFHTTPRequestSerializer serializer];
    [NetworkManage instance].responseSerializer= [AFHTTPResponseSerializer serializer];
    
    [[NetworkManage instance] PUT:path parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id obj =[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if (obj) {
            success(obj);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
    
    
    
}


+(void)Post:(NSString *)path andParams:(NSMutableDictionary *)dic andPhotoArr:(NSMutableArray *)photoArr success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    
    [NetworkManage instance].requestSerializer  = [AFHTTPRequestSerializer serializer];
    
    [[NetworkManage instance] POST:path parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSInteger count =photoArr.count;
        for (NSInteger i =0; i<count; i++) {
            
            UIImage *image = photoArr[i];
            NSData *data = UIImageJPEGRepresentation(image ,1);
            CGFloat size = data.length/1024.0;
            if (size >3000) {
                data = UIImageJPEGRepresentation(image, .1);
            }
            else if (size >2000) {
                data = UIImageJPEGRepresentation(image, .2);
            }
            else if (size >1000) {
                data = UIImageJPEGRepresentation(image, .3);
            }
            else if (size >700) {
                data = UIImageJPEGRepresentation(image, .4);
            }
            else if (size >500) {
                data = UIImageJPEGRepresentation(image, .6);
            }
            //	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
            [formData appendPartWithFileData:data name:@"headerPic" fileName:@"i.jpg" mimeType:@"image/jpeg"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
        
    }];
    
}


@end
