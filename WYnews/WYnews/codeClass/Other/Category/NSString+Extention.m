//
//  NSString+Extention.m
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesDeviceMetrics|NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
    
}
- (CGSize)sizeWithfont:(UIFont*)font MaxX:(CGFloat)maxx
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxx, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}
- (CGSize)sizeWithfont:(UIFont*)font
{
    return [self sizeWithfont:font MaxX:MAXFLOAT];
}

- (NSInteger)Filesize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL dir;
    BOOL exist =  [mgr fileExistsAtPath:self isDirectory:&dir];
    if (exist == NO) return 0;
    if (dir) {//self是一个文件夹
        //找出文件夹中的文件名
        NSArray *subpaths = [mgr subpathsAtPath:self];
        //获得全路径
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths)
        {
            NSString *fullpath = [self stringByAppendingPathComponent:subpath];
            //遍历文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullpath isDirectory:&dir];
            if (dir == NO) {
                totalByteSize +=[[mgr attributesOfItemAtPath:fullpath error:nil][NSFileSize]integerValue];
            }
            
        }
        return totalByteSize;
        
    }else
    {
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize]integerValue];
    }
    
    
}

@end
