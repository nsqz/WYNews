//
//  TopicQuestionModel.h
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BaseModel.h"

@interface TopicQuestionModel : BaseModel
@property (nonatomic, strong) NSString *questionId;
//
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *relatedExpertId;
//
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *userHeadPicUrl;
//
@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) NSString *cTime;

@property (nonatomic, strong) NSString *questionCount;


@end

//"questionId":"QUESTION6607951386972277876",
//"content":"黄与不黄的界限在哪里啊？又没什么参考书推荐一下，能有鉴别规范手册之类的最好了~",
//"relatedExpertId":"EX7353104783909083695",
//"userName":"WindMoon",
//"userHeadPicUrl":"http://imgm.ph.126.net/K3UpQ3Bncd0Mrno3NTo1AA==/3886325003544106529.jpg",
//"state":"replied",
//"cTime":1460092473191 1460100657513