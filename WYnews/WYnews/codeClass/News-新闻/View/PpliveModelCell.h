//
//  PpliveModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PpliveModelCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *replyCountLbl;

@property (weak, nonatomic) IBOutlet UIImageView *YesOrNo;

@property (weak, nonatomic) IBOutlet UILabel *TAGlbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyCountLblConstants;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TAGLblCon;
@property (weak, nonatomic) IBOutlet UIImageView *TimeZ;

@end
