//
//  StrFontModelCell.m
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "StrFontModelCell.h"

#import "StrFontModel.h"
@implementation StrFontModelCell

-(void)setDataWithModel:(StrFontModel *)model {
    
    switch (model.tagging) {
        case theText:
            self.viewCon = 0;
            self.contentLbl.text = model.content;
            self.contentLbl.font = [UIFont systemFontOfSize:17];
            break;
        case subtitle:
            self.viewCon = 0;
            self.contentLbl.text = model.content;
            self.contentLbl.font = [UIFont boldSystemFontOfSize:20];
            break;
        case quoteText:
            self.viewCon.constant = 3;
            self.contentLbl.text = model.content;
            self.contentLbl.font = [UIFont systemFontOfSize:16];
            self.contentLbl.textColor = [UIColor lightGrayColor];
            break;
        case subname:
            self.viewCon.constant = 0;
            self.contentLbl.text = model.content;
            self.contentLbl.font = [UIFont boldSystemFontOfSize:18.5];
//            self.contentLbl.textColor = [UIColor lightGrayColor];
            break;
        default:
            break;
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
