//
//  TopicListViewCell.m
//  WYnewsss
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicListViewCell.h"
#import "TopicListModel.h"

#import <UIImageView+WebCache.h>




@implementation TopicListViewCell
-(void)setDataWithModel:(TopicListModel *)model{
    self.aliasLabel.text =model.alias;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headpicurl] placeholderImage:[UIImage imageNamed:@"comment_profile_default"]];
    // [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.headpicurl]];
    self.headImageView.layer.cornerRadius=25;
    self.careLabel.layer.cornerRadius = 15;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    

    if (([model.concernCount intValue] > 10000)) {
        self.concernCountLabel.text = [NSString stringWithFormat:@"%.1f 万关注",[model.concernCount intValue]/ 10000.0];
    }else if ([model.concernCount intValue] > 0) {
        self.concernCountLabel.text = [NSString stringWithFormat:@"%zd关注", [model.concernCount intValue]];
    }
    
    
    if (([model.questionCount intValue] > 10000)) {
        self.questionCountLabel.text = [NSString stringWithFormat:@"%.2f 万提问", [model.questionCount intValue] / 10000.0];
    }else if (model.questionCount > 0) {
        self.questionCountLabel.text = [NSString stringWithFormat:@"%zd提问", [model.questionCount intValue]];
    }
    [self.picurlImageView sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"302"]];
    //[_picurlImageView sd_setImageWithURL:[NSURL URLWithString:model.picurl]];
    self.classificationLabel.text=model.classification;
    self.nameLabel.text =model.name;
}

- (void)setupLabelTitle:(UILabel *)label count:(NSString *)count title:(NSString *)title {
    NSInteger number = (NSInteger)count;
    if (number > 10000) {
        title = [NSString stringWithFormat:@"%.2f万人",number / 10000.0];
    }else if (number > 0) {
        title = [NSString stringWithFormat:@"%zd", number];
    }
}



- (void)awakeFromNib {
    self.contentView.hidden = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
