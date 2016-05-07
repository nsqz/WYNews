//
//  PhotoModel.h
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"
#import "NewModel.h"
@interface PhotoModel : NewModel

//@property (nonatomic, copy)NSString *imgsrc;//图片地址1
@property (nonatomic, copy)NSString *img2;//图片地址2
@property (nonatomic, copy)NSString *img3;//图片地址3
@property (nonatomic, copy)NSString *source; //小分类

@end
