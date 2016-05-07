//
//  ImgModelCell.m
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "ImgModelCell.h"

#import "ImgModel.h"
@implementation ImgModelCell

-(void)setDataWithModel:(ImgModel *)model {

    self.altLbl.text = model.alt;
    [self.srcimgView sd_setImageWithURL:[NSURL URLWithString:model.src]];
    NSArray *list = [model.pixel componentsSeparatedByString:@"*"];
    NSInteger higet = [[list lastObject] integerValue];
    NSInteger width = [[list firstObject] integerValue];
    self.srcimgCon.constant = (ScreenWidth - 32) *(higet * 1.0 / width);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
