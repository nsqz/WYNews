//
//  GirlModelCell.m
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "GirlModelCell.h"
#import "GirlModel.h"

@implementation GirlModelCell

-(void)setDataWithModel:(GirlModel *)model {
    
    
//    NSLog(@"%@,%ld / %ld = %f" ,model.pixel,higet,width,(higet*1.0 / width));
//    if (model) {
//        <#statements#>
//    }
    self.titleLbl.text = model.digest;
    if (model.imgsrc != nil) {
        
    NSArray *list = [model.pixel componentsSeparatedByString:@"*"];
    NSInteger higet = [[list lastObject] integerValue];
    NSInteger width = [[list firstObject] integerValue];
    self.imgConstranists.constant = ScreenWidth *(higet * 1.0/width);
    [self.imgsrcImg sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        
    } else {
    
        self.imgConstranists.constant = 0 ;
    }
    
    
    NSInteger rep = [model.replyCount integerValue];
    if (rep > 10000) {
        self.replyCountLbl.text = [NSString stringWithFormat:@"%.1f 万",rep/10000.0];
    } else  if (rep > 0 ) {
        NSString *str1 =[NSString stringWithFormat:@"%@",model.replyCount];
        self.replyCountLblConstants.constant =str1.length * 17;
        self.replyCountLbl.text = str1;
    } else {
        self.replyCountLblConstants.constant = 0;
    }

    NSInteger upT = [model.upTimes integerValue];
    if (upT > 10000) {
        self.upTimesLbl.text = [NSString stringWithFormat:@"%.1f 万",upT/10000.0];
    } else  if (upT > 0 ) {
        NSString *str2 =[NSString stringWithFormat:@"%@",model.upTimes];
        self.upTimesLblCon.constant =str2.length * 17;
        self.upTimesLbl.text = str2;
    }
    
    NSInteger dowT = [model.downTimes integerValue];
    if (dowT > 10000) {
        self.downTimesLbl.text = [NSString stringWithFormat:@"%.1f 万",dowT/10000.0];
    } else  if (dowT > 0 ) {
        NSString *str3 =[NSString stringWithFormat:@"%@",model.downTimes];
        self.downTimesCon.constant =str3.length * 17;
        self.downTimesLbl.text = str3;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)zan:(UIButton *)sender {
    NSLog(@"啊~~~~赞~~~");
    sender.selected = !sender.selected;
}

- (IBAction)cai:(id)sender {
    NSLog(@"啊~ 踩!");
}
- (IBAction)Reply:(id)sender {
    NSLog(@"啊啊啊 ！@！！");
}
- (IBAction)share:(id)sender {
    NSLog(@"不错~分享");
}

@end
