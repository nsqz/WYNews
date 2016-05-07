//
//  TopicDetailInsetView.h
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicListModel.h"

@interface TopicDetailInsetView : UIView
@property (weak, nonatomic) IBOutlet UILabel *descL;
@property (weak, nonatomic) IBOutlet UILabel *focuL;
@property (weak, nonatomic) IBOutlet UIView *focuV;

+ (instancetype)TopicDetailInsetViewWith:(TopicListModel *)listModel;



@end
