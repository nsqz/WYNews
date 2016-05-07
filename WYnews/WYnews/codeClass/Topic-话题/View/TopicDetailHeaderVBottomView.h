//
//  TopicDetailHeaderVBottomView.h
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicDetailHeaderVBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseSegment;
@property (nonatomic, strong) void(^segueBlock)();
@end
