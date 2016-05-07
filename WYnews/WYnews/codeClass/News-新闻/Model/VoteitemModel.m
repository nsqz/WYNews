//
//  VoteitemModel.m
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "VoteitemModel.h"

@implementation VoteitemModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.VotId = value;
    }
}

@end
