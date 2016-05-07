//
//  TopicDetailHeaderView.m
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicDetailHeaderView.h"
#import <UIImageView+WebCache.h>
#define HeaderNormalH 153
#define HeaderDescLNormalH 50




@interface TopicDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *descL;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeightConstraint;

/** <#name#> */
@property (nonatomic, weak) UIView *nameLine;

/** <#name#> */
@property (nonatomic, weak) UIView *quesPoint;

@end


@implementation TopicDetailHeaderView




-(void)awakeFromNib {
    TopicDetailHeaderVBottomView *bottomV = [[NSBundle mainBundle] loadNibNamed:@"TopicDetailHeaderVBottomView" owner:nil options:0].lastObject;
    bottomV.segueBlock = ^{
        if (self.bottonSegueBlock) {
            self.bottonSegueBlock();
        }
    };
    [self addSubview:bottomV];
    _bottomV = bottomV;
    
    UIView *nameLine = [[UIView alloc] init];
    nameLine.backgroundColor = RGBColor(150, 150, 150);
    [self.nameL addSubview:nameLine];
    _nameLine = nameLine;
    
    UIView *quesPoint =[[UIView alloc] init];
    quesPoint.backgroundColor = RGBColor(150, 150, 150);
    [self.bottomV.messageLabel addSubview:quesPoint];
    _quesPoint = quesPoint;
    
}

+ (instancetype)topicDetailHeaderViewWithListModel:(TopicListModel *)listModel {
    TopicDetailHeaderView *headerV = [[NSBundle mainBundle] loadNibNamed:@"TopicDetailHeaderView" owner:nil options:0].lastObject;
    //设置头像
    [headerV.iconImgV sd_setImageWithURL:[NSURL URLWithString:listModel.headpicurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        headerV.iconImgV.layer.cornerRadius = 15;
    }];
    //设置namel
    NSString *nameStr = [NSString stringWithFormat:@"%@ | %@",listModel.name, listModel.title];
    
    CGFloat lineX = [[NSString stringWithFormat:@"%@ ", listModel.name] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;
    headerV.nameLine.frame = CGRectMake(lineX + Compensate(2), Compensate(5), 0.5, 11);
    headerV.nameL.text = nameStr;
    headerV.nameL.font = [UIFont systemFontOfSize:12];
    headerV.nameL.textColor = RGBColor(150, 150, 150);
    
    //设置介绍详情descL
    headerV.descL.numberOfLines = 0;
    headerV.descL.font = [UIFont systemFontOfSize:14];
    headerV.descL.textColor = RGBColor(150, 150, 150);
       
   // headerV.descL.text = listModel.name;
    NSMutableAttributedString *descAttrStr = [[NSMutableAttributedString alloc] initWithString:listModel.desc];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.lineSpacing = 4.0;
    [descAttrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, listModel.desc.length)];
    headerV.descL.attributedText = descAttrStr;
    //设置底部条
    NSString *mesStr = [NSString stringWithFormat:@"%@提问%@回复  进行中", listModel.questionCount, listModel.answerCount];
    CGFloat pointX = [[NSString stringWithFormat:@"%@提问", listModel.questionCount] sizeWithAttributes:@{NSAttachmentAttributeName:[UIFont systemFontOfSize:12]}].width;
    headerV.quesPoint.frame = CGRectMake(pointX + Compensate(1), 15, 2, 2);
    headerV.bottomV.messageLabel.textColor = RGBColor(150, 150, 150);
    headerV.bottomV.messageLabel.text = mesStr;
    
    //设置箭头点击
    [headerV.detailButton addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return headerV;
}

+ (void)detailBtnClick:(UIButton *)btn {
    //使按钮翻转
    btn.selected = !btn.isSelected;
    CGFloat descLH;
    //拿到headerV
    TopicDetailHeaderView *headerV = (TopicDetailHeaderView *)btn.superview;
    if (btn.selected == NO) {
        //重新设置约束
        descLH = HeaderDescLNormalH;
        headerV.descHeightConstraint.constant = descLH;
    }else {
        //重新设置约束
        descLH = [headerV.descL.text boundingRectWithSize:CGSizeMake(headerV.descL.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height + Compensate(30);
        headerV.descHeightConstraint.constant = descLH;
    }
    //重新设置headerV的height
    headerV.height = descLH - HeaderDescLNormalH + HeaderNormalH;
    if (headerV.detailBlock) {
        headerV.detailBlock(headerV);
    }
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bottomV.frame = CGRectMake(0, CGRectGetMaxY(self.detailButton.frame), ScreenW, 30);
    
    
}






@end
