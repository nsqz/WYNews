//
//  TitleLabModel.h
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface TitleLabModel : BaseModel

@property (nonatomic, copy)NSString *ename; //中文拼音
@property (nonatomic, copy)NSString *tname; //头标
@property (nonatomic, copy)NSString *tid;   //转场
//@property (nonatomic, copy)NSString *tag;   //

@end
