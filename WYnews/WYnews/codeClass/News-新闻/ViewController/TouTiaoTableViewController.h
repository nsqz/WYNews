//
//  TouTiaoTableViewController.h
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TouTiaoTableViewController : UITableViewController

@property (nonatomic, copy)NSString *runGet;

@property (nonatomic, copy)void (^push) (NSString *);

@end
