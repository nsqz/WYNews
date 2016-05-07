//
//  HeadlinesModel.h
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

@interface HeadlinesModel : BaseModel

@property (nonatomic, copy)NSString *imgsrc; //图片地址
@property (nonatomic, copy)NSString *tag;    //跳转属性
@property (nonatomic, copy)NSString *title;     //标题
@property (nonatomic, copy)NSString *url;   //跳转属性

@property (nonatomic, copy)NSString *docid; //预留属性

@end
