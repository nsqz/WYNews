//
//  VotesModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface VotesModelCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *redLbl;
@property (weak, nonatomic) IBOutlet UILabel *blueLbl;

@property (weak, nonatomic) IBOutlet UILabel *redNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *blueNumberLbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redViewCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueViewCon;
@property (weak, nonatomic) IBOutlet UIView *jinduView;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;

@end
