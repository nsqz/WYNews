//
//  RewardsModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface RewardsModelCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;

@end
