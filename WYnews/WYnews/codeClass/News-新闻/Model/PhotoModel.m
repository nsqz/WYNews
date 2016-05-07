//
//  PhotoModel.m
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"imgextra"]) {
        self.img2 = [value objectAtIndex:0][@"imgsrc"];
        self.img3 = [value objectAtIndex:1][@"imgsrc"];
    }
    
}

@end
