//
//  TopicDetailCellAnswer.m
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicDetailCellAnswer.h"
#import <UIImageView+WebCache.h>
#define ansLNorH 50
#define ansViewNorH 260
#define detailButtonH 30
@interface TopicDetailCellAnswer ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *ansL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ansHeightContraint;




@end


@implementation TopicDetailCellAnswer
- (void)setAnswerModel:(TopicAnswerModel *)answerModel {
    _answerModel = answerModel;
    
    //设置头像
    self.iconImgV.layer.cornerRadius = 15;
    self.iconImgV.clipsToBounds = YES;
    [self.iconImgV sd_setImageWithURL:[NSURL URLWithString:answerModel.specialistHeadPicUrl]];
    //设置namel
    self.nameL.text = answerModel.specialistName;
    self.nameL.font = [UIFont systemFontOfSize:14];
  //  self.nameL.textColor = RGBColor(150, 150, 150);
    
    //设置ansl
    self.ansL.numberOfLines = 0;
    self.ansL.font = [UIFont systemFontOfSize:16];
//    NSMutableAttributedString *ansAttrStr = [[NSMutableAttributedString alloc] initWithString:answerModel.content];
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    style.lineBreakMode = NSLineBreakByTruncatingTail;
//    style.lineSpacing = 4.0;
//    [ansAttrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, answerModel.content.length)];
//    self.ansL.attributedText = ansAttrStr;
//    [self.detailButton addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
    self.ansL.text = answerModel.content;
    self.ansL.font = [UIFont systemFontOfSize:16];
    CGFloat ansH = [answerModel.content boundingRectWithSize:CGSizeMake(ScreenW - 48 - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + Compensate(5);
    self.totalHeight = 55 + ansH ;
    self.ansHeightContraint.constant = ansH;
    
}
//- (void)detailBtnClick:(UIButton *)btn {
//    btn.selected = !btn.isSelected;
//    CGFloat ansLH;
//    TopicDetailCellAnswer *ansView = (TopicDetailCellAnswer *)btn.superview;
//    if (btn.selected == NO) {
//        ansLH = ansLNorH;
//        ansView.ansHeightContraint.constant = ansLH;
//        self.totalHeight = 55 + ansLH;
//    } else {
//        ansLH = [ansView.ansL.text boundingRectWithSize:CGSizeMake(ansView.ansL.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height+Compensate(30);
//        ansView.ansHeightContraint.constant = ansLH;
//        self.totalHeight = 55 + ansLH;
//    }
//    ansView.height = ansLH - ansLNorH + ansViewNorH;
//}

@end
