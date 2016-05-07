//
//  VotesModelCell.m
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "VotesModelCell.h"

#import "VotesModel.h"
#import "VoteitemModel.h"
@implementation VotesModelCell

-(void)setDataWithModel:(VotesModel *)model {

    VoteitemModel *redVoteitem =[model.voteitem firstObject];
    VoteitemModel *blueVoteitem =[model.voteitem lastObject];
    self.redLbl.text = redVoteitem.name;
    self.blueLbl.text = blueVoteitem.name;
    self.redNumberLbl.text = [NSString stringWithFormat:@"%@",redVoteitem.num];
    self.blueNumberLbl.text = [NSString stringWithFormat:@"%@",blueVoteitem.num ];
    
    NSInteger sumnum = [model.sumnum integerValue];
    NSInteger rednum = [redVoteitem.num integerValue];
    NSInteger bluenum = [blueVoteitem.num integerValue];
    
    CGFloat sumWith = self.jinduView.frame.size.width;
    if (sumnum != 0) {
        CGFloat redPercentage = (rednum *1.0 )/ sumnum ;
        CGFloat bluePercentage = (bluenum *1.0 )/ sumnum;
        self.redViewCon.constant = sumWith * redPercentage - 1;
        self.blueViewCon.constant = sumWith * bluePercentage - 1;
    } else {
        self.redViewCon.constant = sumWith  / 2;
        self.blueViewCon.constant = sumWith / 2;
    }
}

- (IBAction)redadd:(UIButton *)sender {
    NSLog(@"红+ 1");
    
    self.blueButton.enabled =NO;
}
- (IBAction)blueAdd:(id)sender {
    NSLog(@"蓝 + 1");
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
