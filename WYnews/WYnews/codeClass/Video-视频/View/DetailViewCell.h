//
//  DetailViewCell.h
//  WYnews
//
//  Created by zhangxiaofan on 16/4/22.
//  Copyright © 2016年 hl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseModel;
@interface DetailViewCell : UITableViewCell
+ (instancetype)createWithTableView:(UITableView *)tableView;

- (void)setDataWithModel:(BaseModel*)model;
@end
