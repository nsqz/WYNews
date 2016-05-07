//
//  PhotoModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PhotoModelCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImg;

@property (weak, nonatomic) IBOutlet UIImageView *img2Img;

@property (weak, nonatomic) IBOutlet UIImageView *img3Img;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *replyCountLbl;

@property (weak, nonatomic) IBOutlet UILabel *sourceLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyCountLblConstants;

@end
