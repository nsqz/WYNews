//
//  TopicDetailHeaderView.h
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicListModel.h"
#import "TopicDetailHeaderVBottomView.h"


@interface TopicDetailHeaderView : UIView
//模型
+ (instancetype)topicDetailHeaderViewWithListModel:(TopicListModel *)listModel;

@property (nonatomic, assign) CGFloat totalHeight;

@property (nonatomic, strong) void(^detailBlock)(TopicDetailHeaderView *);

@property (nonatomic, strong) void(^bottonSegueBlock)();

@property (nonatomic, weak) TopicDetailHeaderVBottomView *bottomV;

@end
