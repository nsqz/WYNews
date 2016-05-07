//
//  TopicDetailHeaderVBottomView.m
//  WYnewsss
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicDetailHeaderVBottomView.h"
@interface TopicDetailHeaderVBottomView ()



@end


@implementation TopicDetailHeaderVBottomView
- (void)awakeFromNib {
    self.backgroundColor = RGBColor(225, 225, 225);
}

- (IBAction)newOrHotChange:(id)sender {
    if (self.segueBlock) {
        self.segueBlock();
    }
    
    
}




@end
