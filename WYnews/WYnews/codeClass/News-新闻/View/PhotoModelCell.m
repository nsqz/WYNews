//
//  PhotoModelCell.m
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "PhotoModelCell.h"
#import "PhotoModel.h"

@implementation PhotoModelCell

-(void)setDataWithModel:(PhotoModel *)model {
    
    self.titleLbl.text = model.title;
    self.sourceLbl.text = model.source;
    [self.imgsrcImg sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    [self.img2Img sd_setImageWithURL:[NSURL URLWithString:model.img2]];
    [self.img3Img sd_setImageWithURL:[NSURL URLWithString:model.img3]];
    
    NSInteger rep = [model.replyCount integerValue];
    self.replyCountLblConstants.constant = 100;
    if (rep > 10000) {
        self.replyCountLbl.text = [NSString stringWithFormat:@"%.1f 万跟帖",rep/10000.0];
    } else  if (rep > 0 ) {
        NSString *str =[NSString stringWithFormat:@"%@跟帖",model.replyCount];
        self.replyCountLblConstants.constant = str.length * 17;
        self.replyCountLbl.text = str;
    }else {
        self.replyCountLblConstants.constant = 0;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
