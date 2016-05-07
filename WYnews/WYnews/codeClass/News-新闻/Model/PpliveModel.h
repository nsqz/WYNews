//
//  PpliveModel.h
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"
#import "NewModel.h"
@interface PpliveModel : NewModel

@property (nonatomic, copy)NSString *user_count;
//@property (nonatomic, copy)NSString *TAG;//标注
//@property (nonatomic, copy)NSString *skipID;//跳转地址
//@property (nonatomic, copy)NSString *skipType; //跳转属性
@property (nonatomic, copy)NSString *start_time;

@end
