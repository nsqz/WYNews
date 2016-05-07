//
//  BaseTableViewCell.h
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
#import <UIImageView+WebCache.h>

@interface BaseTableViewCell : UITableViewCell

-(void)setDataWithModel:(BaseModel *)model;

@end
