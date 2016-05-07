//
//  VideoModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef void (^Play) (UIButton *);
@interface VideoModelCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *altLbl;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (nonatomic, copy)Play play;

@end
