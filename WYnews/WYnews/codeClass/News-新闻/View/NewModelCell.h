//
//  NewModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface NewModelCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *digestLbl;

@property (weak, nonatomic) IBOutlet UILabel *replyCountLbl;

@property (weak, nonatomic) IBOutlet UILabel *TAGLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TAGLblConstants;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyCountLblConstants;

@property (weak, nonatomic) IBOutlet UIImageView *ima;

@end
