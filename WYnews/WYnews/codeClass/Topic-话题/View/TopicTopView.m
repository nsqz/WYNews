//
//  TopicTopView.m
//  WYnewsss
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicTopView.h"
@interface TopicTopView ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@end


@implementation TopicTopView
- (void)awakeFromNib {
    [self.backButton addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backBtnClick {
    if (self.backBlock) {
        self.backBlock();
    }
}

@end
