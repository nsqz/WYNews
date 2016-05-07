//
//  TopicListModel.h
//  WYnewsss
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BaseModel.h"

@interface TopicListModel : BaseModel
//图片下方的描述
@property(nonatomic,copy)NSString *alias;
//关注人数；
@property(nonatomic,assign)NSString *concernCount;
//头像
@property(nonatomic,copy)NSString *headpicurl;
//用户名
@property(nonatomic,copy)NSString *name;
//工作标题
@property(nonatomic,copy)NSString *title;
//提问人数
@property(nonatomic,assign)NSString *questionCount;
//图片
@property(nonatomic,copy)NSString *picurl;
//类型
@property(nonatomic,copy)NSString *classification;

/**网络转接标识*/
@property (nonatomic, copy) NSString *expertId;

/**主持人简介*/
@property (nonatomic, copy) NSString *desc;


/**创建时间*/
@property (nonatomic, copy) NSString *createTime;

/**回复次数*/
@property (nonatomic, strong) NSString *answerCount;


@end


//"expertId":"EX05074551640631430414",
//"alias":"我是CUBA运动员邢洋，关于科比是否能以湖人的胜利完美收官，问我吧！",
//"stitle":"Cuba大神传授绝技",
//"picurl":"http://dingyue.nosdn.127.net/6onPFVab2e6k125AMNxDYvoIHU0CzSYGbC87kPY8xjBTE1460101586617.jpg",
//"name":"邢洋",
//"description":"我是邢洋，清华附中的助理教练，在大学期间曾代表化工大学连续五次获得北京市联赛冠军，并帮助学校破格由乙组升至甲组，有过五年的Cuba的比赛经历，且担任了五年的队长，之后一直留在队里担任助教。",
//"headpicurl":"http://dingyue.nosdn.127.net/HhOmbz0mBG9OByJYkICN0uQrUKSQH8sRDdLrWvu8LAzuB1460099059796.jpg",
//"classification":"体育",
//"state":1,
//"expertState":1,
//"concernCount":1125,
//"createTime":1460100657513,
//"title":"运动员",
//"questionCount":47,
//"answerCount":19
