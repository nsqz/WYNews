//
//  GirlModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface GirlModelCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *upTimesLbl;
@property (weak, nonatomic) IBOutlet UILabel *downTimesLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyCountLblConstants;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgConstranists;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downTimesCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upTimesLblCon;


@end
