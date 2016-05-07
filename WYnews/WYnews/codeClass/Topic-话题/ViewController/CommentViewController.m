//
//  CommentViewController.m
//  WYnewsss
//
//  Created by lanou on 16/4/26.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "CommentViewController.h"
#import "TopicDetailCell.h"
#import "TopicDetailCellQuestion.h"
#import "TopicDetailCellAnswer.h"


@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}





- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
