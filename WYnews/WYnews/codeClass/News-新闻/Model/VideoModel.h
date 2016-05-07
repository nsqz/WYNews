//
//  VideoModel.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

@interface VideoModel : BaseModel

@property (nonatomic, copy)NSString *alt; //下标内容
@property (nonatomic, copy)NSString *m3u8_url;
@property (nonatomic, copy)NSString *mp4_url;
@property (nonatomic, copy)NSString *m3u8Hd_url;
@property (nonatomic, copy)NSString *mp4Hd_url;
@property (nonatomic, copy)NSString *ref; //替换符
@property (nonatomic, copy)NSString *topicid; //id
@property (nonatomic, copy)NSString *vid; //视频跳转 音频为空
@property (nonatomic, copy)NSString *videosource; //类别
@property (nonatomic, copy)NSString *cover;//占位图
//@property (nonatomic, copy)NSString *broadcast; //

@end
