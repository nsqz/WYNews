//
//  TopicDetailCellAnswer.h
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicAnswerModel.h"

@interface TopicDetailCellAnswer : UIView

/**回答者模型*/
@property (nonatomic, strong) TopicAnswerModel *answerModel;

/* 行高 */
@property (nonatomic, assign) CGFloat totalHeight;


@end
