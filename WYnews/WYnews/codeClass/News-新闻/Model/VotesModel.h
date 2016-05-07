//
//  VotesModel.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

/**
 *  投票类
 */
@interface VotesModel : BaseModel


@property (nonatomic, copy)NSString *digest; //正文
@property (nonatomic, copy)NSNumber *sumnum;//总票数
@property (nonatomic, copy)NSString *ref; //替换符
@property (nonatomic, copy)NSString *voteid; //投票id

@property (nonatomic, copy)NSArray *voteitem; //投票信息

@end
