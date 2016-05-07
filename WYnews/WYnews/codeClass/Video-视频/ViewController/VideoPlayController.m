//
//  VideoPlayController.m
//  WYnews
//
//  Created by zhangxiaofan on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "VideoPlayController.h"
#import "DetailPlayCell.h"
#import "VideoDetailModel.h"
#import "VideoDetailRecModel.h"
#import "VideoDetailPlayController.h"
#import "VideoDetailController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface VideoPlayController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *mp4_urlArrar;
@property (weak, nonatomic) IBOutlet UIView *playView;

@property (weak, nonatomic) IBOutlet UILabel *titLe;

@property (weak, nonatomic) IBOutlet UILabel *descriPtion;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;


@property (weak, nonatomic) IBOutlet UIView *topicView;
@property (weak, nonatomic) IBOutlet UIImageView *topicImg;
@property (weak, nonatomic) IBOutlet UILabel *tname;

@property (weak, nonatomic) IBOutlet UILabel *alias;

@property (nonatomic,strong) AFHTTPSessionManager *manager;
/**播放器*/
@property (nonatomic, strong)  MPMoviePlayerController *playerController;

@property (nonatomic,strong) NSMutableArray *desc;

@end

@implementation VideoPlayController
- (NSMutableArray *)desc
{
    if (!_desc) {
        _desc = [NSMutableArray array];
    }
    return _desc;
}
- (NSMutableArray *)mp4_urlArrar
{
    if (!_mp4_urlArrar) {
        _mp4_urlArrar = [NSMutableArray array];
    }
    return _mp4_urlArrar;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)requestData
{
    [SVProgressHUD show];
    NSString *urlString = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/detail/%@.html",self.model.vid];
    [self.manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        VideoDetailModel *detailModel = [[VideoDetailModel alloc] init];
        [detailModel setValuesForKeysWithDictionary:responseObject];
        [self.desc addObject:detailModel.desc];
        for (NSDictionary *dic in responseObject[@"recommend"]) {
            VideoDetailRecModel *model = [[VideoDetailRecModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.mp4_urlArrar addObject:model.mp4_url];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView registerNib:[UINib nibWithNibName:@"DetailPlayCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
            self.tableView.rowHeight = 120;
            self.titLe.text = self.model.title;
            self.descriPtion.text = self.desc.lastObject;
            [self.topicImg sd_setImageWithURL:[NSURL URLWithString:self.model.topicImg]];
            self.tname.text = self.model.topicName;
            self.alias.text = self.model.topicDesc;
            [self gestureRecognizer];
            [self.tableView reloadData];
        });
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self play];
}

- (void)play
{
    _playerController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.model.mp4_url]];
    _playerController.view.frame = self.playView.frame;
    [self.playView addSubview:_playerController.view];
    [_playerController play];
}

- (void)gestureRecognizer
{
     self.topicView.userInteractionEnabled = YES;
     self.topicImg.userInteractionEnabled = YES;
     self.tname.userInteractionEnabled = YES;
     self.alias.userInteractionEnabled = YES;
    [self.topicView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    [self.topicImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    [self.tname addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    [self.alias addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
}

- (void)coverClick
{
    VideoDetailController *detailC = [[VideoDetailController alloc] init];
    detailC.topicSid = self.model.topicSid;
    [self.navigationController pushViewController:detailC animated:YES];
}

#pragma mark -tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailPlayCell *cell = [DetailPlayCell createWithTableView:tableView];
    VideoDetailRecModel *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDetailPlayController *detailPC = [[VideoDetailPlayController alloc] init];
    detailPC.mp4_url = self.mp4_urlArrar[indexPath.row];
    [self.navigationController pushViewController:detailPC animated:YES];
}

@end
