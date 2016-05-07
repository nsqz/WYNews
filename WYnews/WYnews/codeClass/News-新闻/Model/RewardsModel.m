//
//  RewardsModel.m
//  WYnews
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "RewardsModel.h"

@implementation RewardsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.description1 = value;
    }
}

@end
