//
//  NetWorking.m
//  WYnewsss
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "NetWorking.h"
#import "HttpManager.h"
#import <AFNetworking.h>



@interface NetWorking ()

@end

@implementation NetWorking

+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id, NSURLSessionDataTask *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))taskError{
    HttpManager *manager = [HttpManager manager];
    
    return [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        taskError(task,error);
    }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))progress success:(void (^)(id, NSURLSessionDataTask *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))taskError{
    
    HttpManager *manager = [HttpManager manager];
    
    return [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject,task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        taskError(task,error);
    }];
    
}


@end
