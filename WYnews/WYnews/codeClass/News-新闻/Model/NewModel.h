//
//  NewModel.h
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

@interface NewModel : BaseModel

@property (nonatomic, copy)NSString *imgsrc;  //图片地址
@property (nonatomic, copy)NSString *title; //标题
@property (nonatomic, copy)NSString *digest; //简单内容
@property (nonatomic, copy)NSString *replyid; //跳转地址
@property (nonatomic, copy)NSString *imgType;  //为1为一张大图片
@property (nonatomic, copy)NSNumber *replyCount; //跟帖数 如果为0 就不显示

@property (nonatomic, copy)NSString *TAG; //如果有就显示字 如果为视频就显示绿电视
@property (nonatomic, copy)NSString *skipID;//跳转地址
@property (nonatomic, copy)NSString *skipType; //跳转属性 判断属性 - 专题、图片

@property (nonatomic, copy)NSString *interest; //预留
@property (nonatomic, copy) NSString *docid;//同replid
@property (nonatomic, copy)NSString *boardid;//预留跳转地址

@end
