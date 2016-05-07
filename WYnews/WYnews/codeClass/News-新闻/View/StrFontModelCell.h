//
//  StrFontModelCell.h
//  WYnews
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface StrFontModelCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewCon;

@end
