//
//  StrFontModel.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, Tagging) {
    theText = 0,
    subtitle =  1,
    quoteText = 2,
    subname = 3
};

/**
 *  主体字符串
 */
@interface StrFontModel : BaseModel

@property (nonatomic, copy)NSString *content; //内容
@property (nonatomic)Tagging tagging; //标注 判断使用


@end
