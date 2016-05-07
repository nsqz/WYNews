//
//  ImgModel.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

@interface ImgModel : BaseModel

@property (nonatomic, copy)NSString *alt; //图片备注
@property (nonatomic, copy)NSString *pixel; //图片大小 宽×高
@property (nonatomic, copy)NSString *ref; //替换标识符
@property (nonatomic, copy)NSString *src; //图片地址

@end
