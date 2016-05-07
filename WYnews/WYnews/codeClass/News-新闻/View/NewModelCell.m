//
//  NewModelCell.m
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "NewModelCell.h"
#import "NewModel.h"
#import "NSString+Extention.h"

@implementation NewModelCell

-(void)setDataWithModel:(NewModel *)model {
   
    self.titleLbl.text = model.title;
    self.digestLbl.text = model.digest;
    [self.imgsrcImg sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    
    NSInteger rep = [model.replyCount integerValue];
    
      self.TAGLblConstants.constant = 0;
    self.replyCountLblConstants.constant = 100;

    if (rep > 10000) {
        NSString *str =  [NSString stringWithFormat:@"%.1f 万跟帖",rep/10000.0];
         self.replyCountLblConstants.constant = [str sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(120, 21)].width + 5;
        self.replyCountLbl.text = str;
    } else  if (rep > 0 ) {
        NSString *str =[NSString stringWithFormat:@"%@跟帖",model.replyCount];
//        self.replyCountLblConstants.constant = str.length * 17;
        self.replyCountLblConstants.constant = [str sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(120, 21)].width + 5;
        self.replyCountLbl.text = str;
    } else {
        self.replyCountLblConstants.constant = 0;
    }
    
    if ([model.interest isEqualToString:@"S"] ) {
        self.replyCountLblConstants = 0;
        self.TAGLblConstants.constant = 41;
        self.TAGLbl.text = @"置顶";
        self.ima.image = nil;
        [self setTAGLblLayar:[UIColor blueColor]];
    }else  if ([model.skipType isEqualToString:@"special"]) {
            self.TAGLblConstants.constant = 41;
            self.TAGLbl.text = @"专题";
            self.TAGLbl.textColor = [UIColor redColor];
            [self setTAGLblLayar:[UIColor redColor]];
            self.replyCountLblConstants.constant = 0;
        self.ima.image = nil;
    } else if ([model.skipType isEqualToString:@"photoset"]) {
        self.TAGLblConstants.constant = 21;
        self.TAGLbl.text = nil;
        self.ima.image = [UIImage imageNamed:@"照片"];
    } else if (model.TAG != nil) {
        if ([[model.TAG substringToIndex:1] isEqualToString:@"本地"]) {
            self.ima.image = nil;
              self.TAGLblConstants.constant = model.TAG.length * 20;
            self.TAGLbl.text = [model.TAG substringFromIndex:3];
            self.TAGLbl.textColor = [UIColor redColor];
        } else if ([model.TAG isEqualToString:@"视频"]) {
            self.TAGLblConstants.constant = 21;
            self.ima.image = [UIImage imageNamed:model.TAG];
            self.TAGLbl.alpha = 0 ;
        } else if ([model.TAG isEqualToString:@"独家"]){
            self.ima.image = nil;
            self.TAGLbl.alpha = 1;
            self.TAGLblConstants.constant = model.TAG.length * 20;
            self.TAGLbl.text = model.TAG;
            self.TAGLbl.textColor = [UIColor blueColor];
//            self.ima.alpha = 0;
            [self setTAGLblLayar:[UIColor blueColor]];
        }
    }
//    else {
//        self.TAGLblConstants.constant = 0;
//        
//    }
    
    
}

-(void)setTAGLblLayar:(UIColor *)color {
    self.TAGLbl.layer.borderColor = [color CGColor];
    self.TAGLbl.layer.borderWidth = 0.5f;
    self.TAGLbl.layer.masksToBounds = YES;
    self.TAGLbl.layer.cornerRadius = 2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
