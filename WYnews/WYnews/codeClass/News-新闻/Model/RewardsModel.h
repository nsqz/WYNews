//
//  RewardsModel.h
//  WYnews
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

/**
 *  编辑 打赏
 */
@interface RewardsModel : BaseModel

/**
 *  头像
 */
@property (nonatomic, copy)NSString *head;
@property (nonatomic, copy)NSString *name;
/**
 *  描述
 */
@property (nonatomic, copy)NSString *description1;
/**
 *  占位替换符
 */
@property (nonatomic, copy)NSString *ref;



@property (nonatomic, copy)NSString *createDate;

@end
