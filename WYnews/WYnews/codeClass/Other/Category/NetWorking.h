//
//  NetWorking.h
//  WYnewsss
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetWorking : UIViewController
+ (NSURLSessionDataTask *)GET:(NSString *)url parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject,NSURLSessionDataTask * task))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))taskError;

+ (NSURLSessionDataTask *)POST:(NSString *)url parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress *progress))progress success:(void(^)(id responseObject,NSURLSessionDataTask * task))success failure:(void(^)(NSURLSessionDataTask *task,NSError *error))taskError;

@end
