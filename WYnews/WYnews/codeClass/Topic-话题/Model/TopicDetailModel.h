//
//  TopicDetailModel.h
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BaseModel.h"
#import "TopicQuestionModel.h"
#import "TopicAnswerModel.h"
@interface TopicDetailModel : BaseModel

/**提问者*/
@property (nonatomic, strong) TopicQuestionModel *question;
/**回答者*/
@property (nonatomic, strong) TopicAnswerModel *answer;

/* 行高 */
@property (nonatomic, assign) CGFloat totalHeight;

@end
