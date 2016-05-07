//
//  GirlModel.h
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

@interface GirlModel : BaseModel

@property (nonatomic, copy)NSString *digest;              //段子标题
@property (nonatomic, copy)NSString *title;                     //同上
@property (nonatomic, copy)NSString *imgsrc;               // 图片地址
@property (nonatomic, copy)NSNumber *upTimes;       //点赞
@property (nonatomic, copy)NSNumber *downTimes;     // 踩
@property (nonatomic, copy)NSString  *pixel;                   // 规格设置图片大小 宽 * 长
@property (nonatomic, copy)NSString *docid;                 //跳转属性
@property (nonatomic, copy)NSString *boardid;           //备用
@property (nonatomic, copy)NSNumber *replyCount; //跟帖数 如果为0 就不显示

@end
