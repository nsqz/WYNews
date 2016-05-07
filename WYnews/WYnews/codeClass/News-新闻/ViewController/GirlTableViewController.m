//
//  GirlTableViewController.m
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "GirlTableViewController.h"

#import "GirlModel.h"
#import "FactoryTableViewCell.h"
#import "NewsDetailViewController.h"
#import <MJRefresh.h>
@interface GirlTableViewController ()

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)UINavigationController *myNav;

//@property (nonatomic, assign)NSInteger start;

@end

@implementation GirlTableViewController

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)requestData {
//    _runGet = @"T1456112189138";
  

 NSString  *urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/recommend/getChanRecomNews?channel=%@&size=20",self.runGet];

    
    //http://c.3g.163.com/recommend/getChanListNews?channel=T1456112438822 萌宠
    
    NSURLSessionConfiguration*configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL*URL = [NSURL URLWithString:urlStr];
    NSURLRequest*request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask*dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse*response,id responseObject,NSError*error) {
        if  (error) {
            NSLog(@"Error:%@", error);
        }else
        {
//            NSLog(@"%@", responseObject);
            for (NSDictionary *dic in responseObject[self.title]) {
                GirlModel *model  = [[GirlModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
                if (dic[@"prompt"] != nil) {
                    NSLog(@"%@",dic[@"prompt"]);
                }
            }
            
            [self.tableView reloadData];
        }
    }];
    
    [dataTask resume];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    [self requestData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GirlModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([GirlModel class])];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 1000;
    
     self.myNav = self.navigationController;
//      [self setupRefresh];
}

//- (void)setupRefresh {
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
//    //自动改变透明度
//    self.tableView.mj_header.automaticallyChangeAlpha = YES;
//    [self.tableView.mj_header beginRefreshing];
//    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
//    
//}
//-(void)loadNewTopics {
//    _start = 0;
//    [self.dataArray removeAllObjects];
//    [self.tableView reloadData];
//    [self requestData];
//}
//-(void)loadMoreTopics {
//    _start += 10;
//    NSLog(@"%ld",_start);
//    [self.tableView.mj_footer endRefreshing];
//    [self requestData];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseModel *model = self.dataArray[indexPath.row];
    BaseTableViewCell *cell = [FactoryTableViewCell creatTableViewCell:model withTableView:tableView andIndexPath:indexPath];
    [cell setDataWithModel:model];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseModel *model = self.dataArray[indexPath.row];
    GirlModel  *model1 = (GirlModel *)model;
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]initWithNibName:@"NewsDetailViewController" bundle:nil];
    newsDetailVC.replyid = model1.docid;
//    NSLog(@"%@",model1.docid);
    [self.myNav pushViewController:newsDetailVC animated:YES];
    
    //        if (model1.replyid != nil && self.push != nil)  {
    //            self.push(model1.replyid);
    //        }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
