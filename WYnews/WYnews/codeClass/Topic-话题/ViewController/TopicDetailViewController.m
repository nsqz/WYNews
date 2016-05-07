
//
//  TopicDetailViewController.m
//  WYnewsss
//
//  Created by lanou on 16/4/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "TopicDetailInsetView.h"
#import <UIImageView+WebCache.h>
#import "TopicTopView.h"
#import "TopicDetailHeaderView.h"
#import "TopicDetailCell.h"
#import <MJRefresh.h>
#import "Get.h"
#import <AFNetWorking.h>
#import <MJExtension.h>
#import "NetWorking.h"
#import "TopicBottomView.h"
#import "CommentViewController.h"

#define TopicDetailImgH 200
#define TopicDetailInsH 136
#define TopicTopViewH 50

@interface TopicDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
/* 刷新次数 */
@property (nonatomic, assign) NSInteger refreshCount;
/**简介模型*/
@property (nonatomic, strong) NSMutableArray<TopicDetailModel *> *detailArray;
/** 顶部图片 */
@property (nonatomic, weak) UIImageView *topImgV;


/** 顶部视图 */
@property (nonatomic, weak) UIView *topV;


/** 顶部标签 */
@property (nonatomic, weak) UILabel *topL;

/** <#name#> */
@property (nonatomic, weak) TopicDetailInsetView *insetView;


/** <#name#> */
@property (nonatomic, weak) UITableView *queAnsTableV;
/* <#注释#> */
@property (nonatomic, assign, getter=isNewQues) NSInteger newQues;

/**<#name#>*/
@property (nonatomic, strong) UIView *boView;



/**<#name#>*/
@property (nonatomic, strong) TopicBottomView *bottomView;


@end

@implementation TopicDetailViewController
static NSString *const ID = @"cell";

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (NSMutableArray *)detailArray {
    if (!_detailArray) {
        self.detailArray = [[NSMutableArray alloc] init];
    }
    return _detailArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.boView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - TopicTopViewH, ScreenW, TopicTopViewH)];
    self.bottomView = [[NSBundle mainBundle] loadNibNamed:@"TopicBottomView" owner:nil options:0].lastObject;
    [self.boView addSubview:self.bottomView];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.view addSubview:self.boView];
    self.newQues = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [Get getTopicNewsDetailWithExpertId:_listModel.expertId :self.isNewQues :0 :^(NSMutableArray *array) {
        self.detailArray = array;
        [self.queAnsTableV reloadData];
    }];
    // 布局子控件
    [self setTopImgV];
    [self setTopBarV];
    [self setQuesAnsTableV];
    [self setInsetV];
    [self setupTableViewHeaderV];
    [self refreshData];
    //注册cell
    [self.queAnsTableV registerNib:[UINib nibWithNibName:@"TopicDetailCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // Do any additional setup after loading the view.
}

- (void)keyboardWillChangeFrame:(NSNotification *)no {
    //键盘显示\隐藏完毕的frame
    CGRect frame = [no.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//修改承载视图的frame
    self.boView.y = ScreenH - TopicTopViewH - frame.origin.y;
    CGFloat duration = [no.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];

}



- (void)refreshData {
    self.queAnsTableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.queAnsTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.queAnsTableV.mj_header.hidden = YES;
    
    
    
}
- (void)loadNewData {
    [Get getTopicNewsDetailWithExpertId:_listModel.expertId :self.isNewQues :++self.refreshCount :^(NSMutableArray *array) {
        [self.detailArray addObjectsFromArray:array];
        [self.queAnsTableV reloadData];
        [self.queAnsTableV.mj_footer endRefreshing];
        
    }];
}

- (void)loadMoreData {
    [Get getTopicNewsDetailWithExpertId:_listModel.expertId :self.isNewQues :++self.refreshCount :^(NSMutableArray *array) {
        self.detailArray = array;
        [self.queAnsTableV reloadData];
        [self.queAnsTableV.mj_header endRefreshing];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)setTopImgV {
    UIImageView *topImgV = [[UIImageView alloc] init];
    topImgV.frame = CGRectMake(0, -NavBarH, ScreenW, TopicDetailImgH+40);
    [topImgV sd_setImageWithURL:[NSURL URLWithString:_listModel.picurl] placeholderImage:[UIImage imageNamed:@"newsTitleImage"]];
    [self.view addSubview:topImgV];
    self.topImgV = topImgV;
    [self.view sendSubviewToBack:topImgV];
}
- (void)setTopBarV {
    TopicTopView *topV = [[NSBundle mainBundle] loadNibNamed:@"TopicTopView" owner:nil options:0].lastObject;
    topV.backBlock = ^{
        [self backBtnClick];
    };
    topV.frame = CGRectMake(0, StateBarH, ScreenW, NavBarH);
    UILabel *topL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 80, NavBarH)];
    topL.center = CGPointMake(ScreenW / 2, StateBarH);
    topL.text = _listModel.alias;
    topL.textColor = RGBColor(255, 255, 255);
    topL.font = [UIFont systemFontOfSize:15];
    self.topL = topL;
    [topV addSubview:topL];
    [self.view addSubview:topV];
    self.topV = topV;
    
    
}

- (void)setQuesAnsTableV {
    UITableView *queAnsTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarMaxY , ScreenW, ScreenH-NavBarMaxY-TopicTopViewH) style:UITableViewStylePlain];
    queAnsTableV.dataSource = self;
    queAnsTableV.delegate = self;
    queAnsTableV.contentInset = UIEdgeInsetsMake(TopicDetailInsH, 0, 0, 0);
    queAnsTableV.backgroundColor = [UIColor clearColor];
    queAnsTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:queAnsTableV];
    self.queAnsTableV = queAnsTableV;
    [self.view bringSubviewToFront:queAnsTableV];
}

- (void)setInsetV {
    TopicDetailInsetView *insetView = [TopicDetailInsetView TopicDetailInsetViewWith:_listModel];
    self.insetView = insetView;
    insetView.frame = CGRectMake(0, NavBarMaxY, ScreenW, TopicDetailInsH);
    [self.view addSubview:insetView];
}

- (void)setupTableViewHeaderV {
    TopicDetailHeaderView *headerV = [TopicDetailHeaderView topicDetailHeaderViewWithListModel:_listModel];
    headerV.bottonSegueBlock = ^{
        [self changeQuesNewOrHot];
    };
    headerV.frame = CGRectMake(0, 0, ScreenW, 153);
    __weak typeof(self) weakSelf = self;
    headerV.detailBlock = ^(TopicDetailHeaderView *headerView){
        weakSelf.queAnsTableV.tableHeaderView = headerView;
        [weakSelf.queAnsTableV reloadData];
    };
    self.queAnsTableV.tableHeaderView = headerV;
}
- (void)changeQuesNewOrHot {
    self.newQues = !self.isNewQues;
    
    [self.queAnsTableV.mj_header beginRefreshing];
    
    self.refreshCount = 0;
}
#pragma mark - tableViewDataSource

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.detailArray.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.detailModel = self.detailArray[indexPath.row];
    //NSLog(@"%@ ", self.detailArray);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 将算过的totalHeight存储，下次直接返回
    if (self.detailArray[indexPath.row].totalHeight==0) {
        self.detailArray[indexPath.row].totalHeight = [TopicDetailCell totalHeightWithModel:self.detailArray[indexPath.row]];
    }
    return self.detailArray[indexPath.row].totalHeight;
}

#pragma mark - Table view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取消下拉控件隐藏
    self.queAnsTableV.mj_header.hidden = NO;
    
    // 计算insetView的偏移位置
    if (scrollView.contentOffset.y>=-TopicDetailInsH) {
        self.insetView.frame = CGRectMake(0, NavBarMaxY-TopicDetailInsH-scrollView.contentOffset.y, ScreenW, 136);
        if (scrollView.contentOffset.y>0) return;
        // 顶部图片下移
        self.topImgV.frame = CGRectMake(0, -40+(scrollView.contentOffset.y+TopicDetailInsH)/136*40, ScreenW, self.topImgV.height);
        // 下拉控件隐藏
        self.queAnsTableV.mj_header.hidden = YES;
    }
    // 改变insetView的透明度
    self.insetView.descL.alpha = 1 - (scrollView.contentOffset.y+TopicDetailInsH)/80.0;
    self.insetView.alpha = 1 - (scrollView.contentOffset.y+TopicDetailInsH)/100.0;
    
    // 改变顶部文字的透明度
    self.topL.alpha = (scrollView.contentOffset.y+TopicDetailInsH)/100;
    
    
}

#pragma mark - 监听返回按钮点击

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
