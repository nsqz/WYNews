//
//  HeadlinesModel.m
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "HeadlinesModel.h"

@implementation HeadlinesModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"photosetID"] || [key isEqualToString:@"skipID"]) {
        self.url = value;
    }
    if ([key isEqualToString:@"skipType"]) {
        self.tag = value;
    }
    
}

@end
