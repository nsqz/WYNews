//
//  SearchViewController.m
//  WYnewsss
//
//  Created by lanou on 16/4/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation SearchViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (UIView *view in [[self.searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            [textField becomeFirstResponder];
            
        }
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.backgroundColor = RGBColor(237, 237, 237);
    
    self.view.backgroundColor = GlobalBg;
    self.searchBar.delegate = self;
    for (UIView *view in [[self.searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton *)view;
            [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
            [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [cancelButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
    }
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];

}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
