//
//  DetailPlayCell.h
//  WYnews
//
//  Created by zhangxiaofan on 16/4/25.
//  Copyright © 2016年 hl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseModel;
@interface DetailPlayCell : UITableViewCell
+ (instancetype)createWithTableView:(UITableView *)tableView;

- (void)setDataWithModel:(BaseModel*)model;
@end
