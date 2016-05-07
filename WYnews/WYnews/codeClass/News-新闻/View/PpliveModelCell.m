//
//  PpliveModelCell.m
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "PpliveModelCell.h"
#import "PpliveModel.h"
#import "DateClass.h"

@implementation PpliveModelCell

-(void)setDataWithModel:(PpliveModel *)model {
    self.TimeZ.alpha = 1;
    self.TAGLblCon.constant = 83;
 self.TAGlbl.textColor = [UIColor blueColor];
self.titleLbl.text = model.title;
[self.imgsrcImg sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
if ([model.TAG isEqualToString:@"直播预告"]) {
    self.YesOrNo.image = nil;
    self.TAGlbl.text = @"开启通知";
     NSString *currentDay =  [DateClass GetBeijingTime:complete];
    self.TAGlbl.textAlignment = NSTextAlignmentRight;
    NSInteger currDay = [DateClass TimeByDay:currentDay];
    NSInteger startDay = [DateClass TimeByDay:model.start_time];
    
    NSArray *startList = [model.start_time componentsSeparatedByString:@" "];
    switch (startDay - currDay) {
        case 0:
            self.replyCountLbl.text = [NSString stringWithFormat:@"今天 %@",[startList lastObject]];
            break;
        case 1:
            self.replyCountLbl.text = [NSString stringWithFormat:@"明天 %@",[startList lastObject]];
            break;
        default:
            self.replyCountLbl.text = [NSString stringWithFormat:@"%@ %@",[[startList firstObject] substringFromIndex:5],[startList lastObject]];
            break;
    }
//    NSString *strDay = [[[startList firstObject] componentsSeparatedByString:@"-"] lastObject];

//    if ([currentDay isEqualToString:strDay]) {
//        self.replyCountLbl.text = [NSString stringWithFormat:@"今天 %@",[startList lastObject]];
//    } else {
//        self.replyCountLbl.text = [NSString stringWithFormat:@"明天 %@",[startList lastObject]];
//    }
    
} else {
    self.TAGLblCon.constant = 70;
    self.TimeZ.alpha = 0;
    self.TAGlbl.textAlignment = NSTextAlignmentCenter;
    self.TAGlbl.text = model.TAG;
    NSInteger rep = [model.user_count integerValue];
    self.replyCountLblConstants.constant = 100;
    if (rep > 10000)
    {
    self.replyCountLbl.text = [NSString stringWithFormat:@"%.1f 万参与",rep/10000.0];
    }  else  if (rep > 0 )
    {
    NSString *str =[NSString stringWithFormat:@"%@参与",model.user_count];
    self.replyCountLblConstants.constant = str.length * 17;
    self.replyCountLbl.text = str;
    } else
    {
    self.replyCountLblConstants.constant = 0;
        self.replyCountLbl.text = nil;
    }
}
    if ([model.TAG isEqualToString:@"直播回顾"]) {
    [self setTAGLblLayar:[UIColor blackColor]];
    self.TAGlbl.textColor = [UIColor lightGrayColor];
}else {
    [self setTAGLblLayar:[UIColor blueColor]];
}

}
-(void)setTAGLblLayar:(UIColor *)color {
self.TAGlbl.layer.borderColor = [color CGColor];
self.TAGlbl.layer.borderWidth = 0.5f;
self.TAGlbl.layer.masksToBounds = YES;
self.TAGlbl.layer.cornerRadius = 2;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
// Drawing code
}
*/

@end
