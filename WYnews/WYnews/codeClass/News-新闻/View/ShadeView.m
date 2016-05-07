//
//  ShadeView.m
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "ShadeView.h"

@implementation ShadeView

/*
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.openBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        self.openBtn 
    }
    return self;
}
*/
 
- (IBAction)openView:(UIButton*)sender {
    NSLog(@"%f",sender.frame.origin.x);
    if (_isOpen) {
        if (self.ShadeOpen) {
            self.ShadeOpen();
        }
        [UIView animateWithDuration:1.0 animations:^{
            sender.transform = CGAffineTransformMakeRotation(M_PI_4);
        }];
        _isOpen = NO;
    } else {
        
        [UIView animateWithDuration:1.0 animations:^{
            sender.transform = CGAffineTransformMakeRotation(0);
            
        }];
        _isOpen = YES;
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
