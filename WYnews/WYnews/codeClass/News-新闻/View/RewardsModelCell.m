//
//  RewardsModelCell.m
//  WYnews
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "RewardsModelCell.h"

#import "RewardsModel.h"
@implementation RewardsModelCell

-(void)setDataWithModel:(RewardsModel *)model {
    self.headImg.layer.cornerRadius = 40;
    self.nameLbl.text = model.name;
    self.descriptionLbl.text = model.description1;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.head]];
    
}

- (IBAction)ArewardArewardAReward:(id)sender {
    NSLog(@"您并没有钱");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
