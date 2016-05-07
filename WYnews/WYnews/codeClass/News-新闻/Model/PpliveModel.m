//
//  PpliveModel.m
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "PpliveModel.h"

@implementation PpliveModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"live_info"]) {
        self.user_count = value[@"user_count"];
        self.start_time = value[@"start_time"];
//        NSLog(@"%@ %@",)
        
    }
}

@end
