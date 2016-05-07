//
//  NewDetailModel.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

@interface NewDetailModel : BaseModel

@property (nonatomic, copy)NSString *dkeys; //似乎并没什么卵用
@property (nonatomic, copy)NSString *hasNext; //false
@property (nonatomic, copy)NSString *shareLink; //手机网页便捷地址

@property (nonatomic, copy)NSString *replyBoard; //跳转预留
/**
 *  头内容
 */
@property (nonatomic, copy)NSString *title; //标题
@property (nonatomic, copy)NSString *ptime; //创建时间
@property (nonatomic, copy)NSString *source; //单位
/**
 *  最主要的东西
 */
@property (nonatomic, copy) NSString *body;  //主体
@property (nonatomic, strong) NSArray  *imgArr; // 图片数组
@property (nonatomic, strong) NSArray  *votesArr; //投票数组
@property (nonatomic, strong) NSArray  *videoArr; //视频数组
@property (nonatomic, strong) NSArray *rwardArr;  //编辑人员数组

/**
 *  尾内容
 */
@property (nonatomic, copy)NSString *ec; //责任编辑

@end
