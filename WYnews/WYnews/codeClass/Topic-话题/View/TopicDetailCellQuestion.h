//
//  TopicDetailCellQuestion.h
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicQuestionModel.h"


@interface TopicDetailCellQuestion : UIView

/* 行高 */
@property (nonatomic, assign) CGFloat totalHeight;

/**提问者模型*/
@property (nonatomic, strong)  TopicQuestionModel*questionModel;


@end
