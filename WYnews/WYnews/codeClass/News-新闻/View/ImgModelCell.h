//
//  ImgModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ImgModelCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *srcimgView;
@property (weak, nonatomic) IBOutlet UILabel *altLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *srcimgCon;

@end
