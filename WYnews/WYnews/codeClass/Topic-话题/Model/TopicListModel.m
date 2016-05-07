//
//  TopicListModel.m
//  WYnewsss
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicListModel.h"


@implementation TopicListModel

//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    return @{@"desc" : @"description"};
//}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.desc = value;
    }
}

@end
