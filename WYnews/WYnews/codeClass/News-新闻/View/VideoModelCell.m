//
//  VideoModelCell.m
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "VideoModelCell.h"

#import "VideoModel.h"
@implementation VideoModelCell

-(void)setDataWithModel:(VideoModel *)model {
    self.altLbl.text = model.alt;
    [self.coverImgView  sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    
}

- (IBAction)playVideo:(UIButton *)sender {
//    self.play(sender);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
