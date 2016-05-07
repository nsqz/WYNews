//
//  TopicDetailCell.m
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicDetailCell.h"
#import "TopicDetailCellQuestion.h"
#import "TopicDetailCellAnswer.h"



@interface TopicDetailCell ()
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/** 提问cell */
@property (nonatomic, weak) TopicDetailCellQuestion *quesView;


/** 回答cell */
@property (nonatomic, weak) TopicDetailCellAnswer *ansView;


/** 视图 */
@property (nonatomic, weak) UIView *marginV;


/** <#name#> */
@property (nonatomic, weak) UIView *separeteLine;


@end





@implementation TopicDetailCell

- (void)awakeFromNib
{
    UIView *separeteLine = [[UIView alloc] init];
    separeteLine.backgroundColor = GlobalBg;
    [self addSubview:separeteLine];
    _separeteLine = separeteLine;
    
    UIView *marginV = [[UIView alloc] init];
    marginV.backgroundColor = GlobalBg;
    [self addSubview:marginV];
    _marginV = marginV;
}

- (UIView *)quesView
{
    if (!_quesView) {
        TopicDetailCellQuestion *quesView = [[NSBundle mainBundle] loadNibNamed:@"TopicDetailCellQuestion" owner:nil options:0].lastObject;
        [self addSubview:quesView];
        _quesView = quesView;
    }
    return _quesView;
}
- (UIView *)ansView
{
    if (!_ansView) {
        TopicDetailCellAnswer *ansView = [[NSBundle mainBundle] loadNibNamed:@"TopicDetailCellAnswer" owner:nil options:0].lastObject;
        [self addSubview:ansView];
        _ansView = ansView;
    }
    return _ansView;
}

- (NSString *)getTime:(long)second {
//    second = second / 1000;
    NSDate *date = [NSDate date];
    NSDate *a = [date initWithTimeIntervalSince1970:second];
    NSString *time = [a descriptionWithLocale:@""];
    NSString *timeS = [time substringToIndex:10];
    return timeS;
    
}

- (void)setDetailModel:(TopicDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    long timerr = [detailModel.question.cTime longLongValue];
    
    long seconde = timerr / 1000;
    self.timeLabel.text = [self getTime:seconde];    // 设置提问数据
    self.quesView.questionModel = detailModel.question;
    self.quesView.frame = CGRectMake(0, 0, ScreenW, self.quesView.totalHeight);
    // 设置回答数据
    self.ansView.answerModel = detailModel.answer;
    self.ansView.frame = CGRectMake(0, self.quesView.totalHeight, ScreenW, self.ansView.totalHeight);
    // 设置分割线与分隔View
    self.marginV.frame = CGRectMake(0, CGRectGetMaxY(self.ansView.frame)+50, ScreenW, Margin);
    self.separeteLine.frame = CGRectMake(40, CGRectGetMaxY(self.quesView.frame)+Margin, ScreenW-40-Margin, 0.5);
    [self bringSubviewToFront:self.separeteLine];
    
    [self.repostButton setTitle:detailModel.answer.replyCount forState:UIControlStateNormal];
    [self.zanButton setTitle:detailModel.answer.supportCount forState:UIControlStateNormal];
}

+ (CGFloat)totalHeightWithModel:(TopicDetailModel *)detailModel
{
    TopicDetailCellQuestion *quesView = [[NSBundle mainBundle] loadNibNamed:@"TopicDetailCellQuestion" owner:nil options:0].lastObject;
    quesView.questionModel = detailModel.question;
    
    TopicDetailCellAnswer *ansView = [[NSBundle mainBundle] loadNibNamed:@"TopicDetailCellAnswer" owner:nil options:0].lastObject;
    ansView.answerModel = detailModel.answer;
    
    
    return quesView.totalHeight+ansView.totalHeight+50+Margin;
}

@end
