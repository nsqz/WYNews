//
//  DateClass.h
//  WYnews
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 hl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DateAlways) {
    DATE,
    always,
    complete,
    Day,
    month
};
@interface DateClass : NSObject

//获取当前时间
+(NSString *)GetBeijingTime:(DateAlways)dateAlways;

+(NSString *)getTime:(long)second;

//根据
+(NSInteger )TimeByDay:(NSString *)time;

@end
