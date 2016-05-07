//
//  DetailPlayCell.m
//  WYnews
//
//  Created by zhangxiaofan on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "DetailPlayCell.h"
#import "VideoDetailModel.h"
#import "VideoDetailRecModel.h"
#import <UIImageView+WebCache.h>
@interface DetailPlayCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *timeScale;

@end

@implementation DetailPlayCell
+ (instancetype)createWithTableView:(UITableView *)tableView
{
    NSString *ID = @"Cell";
    DetailPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DetailPlayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setDataWithModel:(VideoDetailRecModel *)model
{
    [self.coverImg sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.title.text = model.title;
    self.timeScale.text = [NSString stringWithFormat:@"%02d:%02d",[model.length intValue]/60,[model.length intValue]%60];;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
