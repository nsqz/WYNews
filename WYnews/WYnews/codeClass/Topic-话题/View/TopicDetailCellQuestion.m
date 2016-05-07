//
//  TopicDetailCellQuestion.m
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicDetailCellQuestion.h"
#import <UIImageView+WebCache.h>

@interface TopicDetailCellQuestion ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *quesL;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quesHeightContraint;


@end




@implementation TopicDetailCellQuestion

- (void)setQuestionModel:(TopicQuestionModel *)questionModel {
    _questionModel = questionModel;
    
    //设置头像
    self.iconImgV.layer.cornerRadius = 15;
    self.iconImgV.clipsToBounds = YES;
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:questionModel.userHeadPicUrl]];
    //设置namel
    self.nameL.text = questionModel.userName;
    self.nameL.font = [UIFont systemFontOfSize:14];
    self.nameL.textColor = RGBColor(150, 150, 150);
    
    //设置ansl
    self.quesL.text = questionModel.content;
    self.quesL.font = [UIFont systemFontOfSize:16];
    CGFloat queH = [questionModel.content boundingRectWithSize:CGSizeMake(ScreenW - 48 - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
    self.totalHeight = 55 + queH + 20;
    self.quesHeightContraint.constant = queH + 20;
    
}

@end
