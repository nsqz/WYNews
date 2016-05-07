//
//  SCBaseViewController.m
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "SCBaseViewController.h"

@interface SCBaseViewController ()

@end

@implementation SCBaseViewController

#pragma mark - 生命周期方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // scrollView的属性
    self.VCScrollView.pagingEnabled = YES;
    self.VCScrollView.showsHorizontalScrollIndicator = NO;
    self.VCScrollView.showsVerticalScrollIndicator = NO;
    self.TitleScrollView.showsHorizontalScrollIndicator = NO;
    self.TitleScrollView.showsVerticalScrollIndicator = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
