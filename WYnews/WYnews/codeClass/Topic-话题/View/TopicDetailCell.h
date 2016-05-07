//
//  TopicDetailCell.h
//  WYnewsss
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicDetailModel.h"
#import "TopicQuestionModel.h"
#import "TopicAnswerModel.h"
#import "TopicListModel.h"

@interface TopicDetailCell : UITableViewCell


/**<#name#>*/
@property (nonatomic, strong) TopicDetailModel *detailModel;

+ (CGFloat)totalHeightWithModel:(TopicDetailModel *)detailModel;
/**<#name#>*/
@property (nonatomic, strong) TopicListModel *listModel;

/* <#注释#> */
@property (nonatomic, assign) CGFloat totalHeight;
@end
