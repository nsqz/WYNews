//
//  VoteitemModel.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

@interface VoteitemModel : BaseModel

@property (nonatomic, copy)NSString *VotId;
@property (nonatomic, copy)NSString *name; //投票名
@property (nonatomic, copy)NSNumber *num; //选择人数


@end
