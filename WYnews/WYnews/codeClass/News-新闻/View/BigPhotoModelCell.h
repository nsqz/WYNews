//
//  BigPhotoModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"
//#import "NSString+Extention.h"

@interface BigPhotoModelCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImg;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *replyCountLbl;

@property (weak, nonatomic) IBOutlet UILabel *sourceLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyCountLblConstants;

@end
