//
//  Get.h
//  WYnewsss
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Get : NSObject
+ (void)getTopicNewsDetailWithExpertId:(NSString *)expertId :(BOOL)isNewQues :(NSInteger)pageCount :(void(^)(NSMutableArray *))complete;

@end
