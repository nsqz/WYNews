//
//  TopicListViewController.m
//  WYnewsss
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopicListViewController.h"
#import "NetWorkRequestManager.h"
#import "TopicListModel.h"
#import "FactoryTableViewCell.h"
#import "BaseTableViewCell.h"
#import <MJRefresh.h>
#import "TopicDetailViewController.h"

@interface TopicListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *topicTableView;

@property (nonatomic)int list;

@end

@implementation TopicListViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [_topicTableView registerNib:[UINib nibWithNibName:@"TopicListViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([TopicListModel class])];
    self.topicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self setupRefresh];
    // Do any additional setup after loading the view from its nib.
}
-(void)requestData{
    [NetWorkRequestManager requestWithType:GET urlString:@"http://c.m.163.com/newstopic/list/expert/0-10.html" parDic:@{} finish:^(NSData *data) {
        NSDictionary *dataDic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        // NSLog(@"dataDic=%@",dataDic);
        NSArray *array =dataDic[@"data"][@"expertList"];
        for (NSDictionary *dic in array) {
            TopicListModel *newsModel =[[TopicListModel alloc]init];
            [newsModel setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:newsModel];
            // NSLog(@"%@",newsModel.alias);
        }
        // NSLog(@"dataArray = %@",_dataArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_topicTableView reloadData];
        });
    } error:^(NSError *error) {
//       EX-374860030729771768
        // NSLog(@"%@",[error localizedDescription]);
    }];
}
- (void)setupRefresh {
    self.topicTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.topicTableView.mj_header.automaticallyChangeAlpha = YES;
    [self.topicTableView.mj_header beginRefreshing];
    
    self.topicTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

- (void)loadNewTopics {
    _list = 0;
    if (self.dataArray) {
        [self.dataArray removeAllObjects];
    }
    [NetWorkRequestManager requestWithType:GET urlString:[NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/expert/%d-10.html",_list] parDic:@{} finish:^(NSData *data) {
        NSDictionary *dataDic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        // NSLog(@"dataDic=%@",dataDic);
        NSArray *array =dataDic[@"data"][@"expertList"];
        for (NSDictionary *dic in array) {
            TopicListModel *newsModel =[[TopicListModel alloc]init];
            [newsModel setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:newsModel];
            // NSLog(@"%@",newsModel.alias);
        }
        // NSLog(@"dataArray = %@",_dataArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_topicTableView reloadData];
            [self.topicTableView.mj_header endRefreshing];

        });

    } error:^(NSError *error) {
        
        [self.topicTableView.mj_header endRefreshing];
        
        NSLog(@"%@",error);
    }];
}
-(void)loadMoreTopics {
    
    _list += 10;
    [NetWorkRequestManager requestWithType:GET urlString:[NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/expert/%d-10.html",_list]  parDic:@{} finish:^(NSData *data) {
        NSDictionary *dataDic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        // NSLog(@"dataDic=%@",dataDic);
        NSArray *array =dataDic[@"data"][@"expertList"];
        for (NSDictionary *dic in array) {
            TopicListModel *newsModel =[[TopicListModel alloc]init];
            [newsModel setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:newsModel];
            // NSLog(@"%@",newsModel.alias);
        }
        // NSLog(@"dataArray = %@",_dataArray);
        dispatch_async(dispatch_get_main_queue(), ^{
        [_topicTableView reloadData];
        [self.topicTableView.mj_footer endRefreshing];

        });
        
    } error:^(NSError *error) {
        [self.topicTableView.mj_footer endRefreshing];

        NSLog(@"%@",error);
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 338;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopicListModel *model =self.dataArray[indexPath.row];
    BaseTableViewCell *cell =[FactoryTableViewCell creatTableViewCell:model withTableView:tableView andIndexPath:indexPath];
    [cell setDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicDetailViewController *detail = [[TopicDetailViewController alloc] init];
    detail.listModel = _dataArray[indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
