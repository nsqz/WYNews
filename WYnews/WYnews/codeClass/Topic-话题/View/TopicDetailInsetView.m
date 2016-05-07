//
//  TopicDetailInsetView.m
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicDetailInsetView.h"

@implementation TopicDetailInsetView

+ (instancetype)TopicDetailInsetViewWith:(TopicListModel *)listModel {
    TopicDetailInsetView *insetView = [[NSBundle mainBundle] loadNibNamed:@"TopicDetailInsetView" owner:nil options:0].lastObject;
    insetView.descL.text = listModel.alias;
    insetView.descL.textColor = [UIColor whiteColor];
    insetView.descL.numberOfLines = 0;
    insetView.descL.font = [UIFont systemFontOfSize:15];
    NSString *concernCountStr = [NSString stringWithFormat:@"%d", [listModel.concernCount intValue]];
    if ([listModel.concernCount intValue] > 10000) {
        concernCountStr = [NSString stringWithFormat:@"%0.1f万",[listModel.concernCount intValue] / 10000.0];
    }
    insetView.focuL.text = [NSString stringWithFormat:@"—— %@ 关注 ——", concernCountStr];
    insetView.focuL.textColor = [UIColor whiteColor];
    insetView.focuL.font = [UIFont systemFontOfSize:12];
    
    insetView.focuL.layer.cornerRadius = 12.5;
    insetView.focuL.clipsToBounds = YES;
    return insetView;
}

@end
