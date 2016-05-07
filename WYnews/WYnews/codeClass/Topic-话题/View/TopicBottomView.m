//
//  TopicBottomView.m
//  WYnewsss
//
//  Created by lanou on 16/4/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicBottomView.h"

@interface TopicBottomView ()

@property (weak, nonatomic) IBOutlet UITextField *textField;


@end
@implementation TopicBottomView
- (void)awakeFromNib {
    self.textField.layer.cornerRadius = 15;
}


@end
