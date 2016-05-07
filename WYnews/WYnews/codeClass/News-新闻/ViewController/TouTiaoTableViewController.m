//
//  TouTiaoTableViewController.m
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//


#import <Photos/Photos.h>
#import "TouTiaoTableViewController.h"
#import "NetWorkRequestManager.h"
#import "HeadlinesModel.h"
#import "CycleScrollView.h"
#import <UIImageView+WebCache.h>
#import "BigPhotoModel.h"
#import "PhotoModel.h"
#import "PpliveModel.h"
#import "FactoryTableViewCell.h"
#import "NewsDetailViewController.h"
#import <MJRefresh.h>
#import "MWCommon.h"
#import "MWPhotoBrowser.h"


@interface TouTiaoTableViewController () <MWPhotoBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *carouselArray; // 滚动列表数据源

@property (nonatomic, strong) CycleScrollView *cycleScrollView; // 滚动列表视图

@property (nonatomic, strong)UIView *headerView;

@property (nonatomic)NSInteger start;

@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)UINavigationController *myNav;

@property (nonatomic, strong)NSMutableArray *photos;//

@end

@implementation TouTiaoTableViewController

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)carouselArray {
    if (!_carouselArray) {
        self.carouselArray = [NSMutableArray array];
    }
    return _carouselArray;
}

-(void)requestData {
    NSString *urlStr = nil;
    if (self.runGet == nil) {
        urlStr  =[NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%ld-20.html?from=toutiao",_start];
        self.runGet = @"T1348647853363";
    }else {
        urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/%ld-20.html",self.runGet,_start];
    }
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
            NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        for (NSDictionary *dic in dataDic[self.runGet])
        {
//            NSLog(@"%@",dic);
            if (dic[@"prompt"] != nil) {
                NSLog(@"执行方法 %@",dic[@"prompt"]);
            }
            if (dic[@"hasHead"] != nil&& _start == 0)       {
                HeadlinesModel *model = [[HeadlinesModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.carouselArray addObject:model];
                for (NSDictionary *adsDic in dic[@"ads"])
                {
                    HeadlinesModel *model = [[HeadlinesModel alloc]init];
                    [model setValuesForKeysWithDictionary:adsDic];
                    [self.carouselArray addObject:model];
                }
            } else if ([dic[@"imgType"] intValue]==1)
            {
                
                if ([dic[@"TAG"] isEqualToString:@"正在直播"]) {
                    PpliveModel *pplive = [[PpliveModel alloc]init];
                    [pplive setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:pplive];
                    
                } else {
                    BigPhotoModel *bigPhoto = [[BigPhotoModel alloc]init];
                    [bigPhoto setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:bigPhoto];
                }
            } else if (dic[@"imgextra"] != nil)
            {
                PhotoModel *photo = [[PhotoModel alloc]init];
                [photo setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:photo];
                //                    NSLog(@"%@",[dic[@"imgextra"] objectAtIndex:0][@"imgsrc"]);
                //                    NSLog(@"%@ %@",photo.img2,photo.img3);
            } else {
                NewModel *newModel = [[NewModel alloc]init];
                [newModel setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:newModel];
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //                NSLog(@"%ld",self.carouselArray.count);
            
            // 创建滚动列表视图
            if (self.carouselArray.count <= 2) {
                
                [self creatHeaderView];
                
            }else {
                
                [self creatCycleScrollView];
                
            }
            
            [self.tableView reloadData];
             [self.tableView.mj_header endRefreshing];
            
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
          [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    
    }];
    
    /*
    [NetWorkRequestManager requestWithType:GET urlString:urlStr parDic:nil finish:^(NSData *data) {
        
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            for (NSDictionary *dic in dataDic[self.runGet])
            {
                        if (dic[@"prompt"] != nil) {
                             NSLog(@"执行方法 %@",dic[@"prompt"]);
                         }
                        if (dic[@"hasHead"] != nil&& _start == 0)       {
                        HeadlinesModel *model = [[HeadlinesModel alloc]init];
                         [model setValuesForKeysWithDictionary:dic];
                         [self.carouselArray addObject:model];
                          for (NSDictionary *adsDic in dic[@"ads"])
                          {
                              HeadlinesModel *model = [[HeadlinesModel alloc]init];
                              [model setValuesForKeysWithDictionary:adsDic];
                              [self.carouselArray addObject:model];
                          }
            } else if ([dic[@"imgType"] intValue]==1)
            {
               
                    if ([dic[@"TAG"] isEqualToString:@"正在直播"]) {
                        PpliveModel *pplive = [[PpliveModel alloc]init];
                        [pplive setValuesForKeysWithDictionary:dic];
                        [self.dataArray addObject:pplive];
                        
                    } else {
                    BigPhotoModel *bigPhoto = [[BigPhotoModel alloc]init];
                    [bigPhoto setValuesForKeysWithDictionary:dic];
                        [self.dataArray addObject:bigPhoto];
                    }
                } else if (dic[@"imgextra"] != nil)
                {
                    PhotoModel *photo = [[PhotoModel alloc]init];
                    [photo setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:photo];
//                    NSLog(@"%@",[dic[@"imgextra"] objectAtIndex:0][@"imgsrc"]);
//                    NSLog(@"%@ %@",photo.img2,photo.img3);
                } else {
                    NewModel *newModel = [[NewModel alloc]init];
                    [newModel setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:newModel];
                }
                
            }
     
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"%ld",self.carouselArray.count);
                
                // 创建滚动列表视图
                if (self.carouselArray.count <= 2) {
                    
                    [self creatHeaderView];
                    
                }else {
                    
                [self creatCycleScrollView];
                
                }
                
                [self.tableView reloadData];
            });
                           
          } error:nil];
     */
    
}
-(void)creatHeaderView {
    if (self.headerView.subviews.count > 4) {
        return;
    }
    
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/4.6)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:View.bounds];
    HeadlinesModel *model = [_carouselArray firstObject];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, View.frame.size.height- 40, View.frame.size.width - 100, 21)];
    label.text = model.title;
    label.textColor = [UIColor whiteColor];
//    NSLog(@"%@ ,%@",model.title,model.imgsrc)
    //        [viewArray addObject:label];
    [imageView addSubview:label];
    [View addSubview:imageView];
    
    [self.headerView addSubview:View];
    
}

//创建首页上面的滚动列表视图
- (void)creatCycleScrollView {
    if (self.cycleScrollView != nil) {
        return;
    }
    self.cycleScrollView  =  [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0 , ScreenWidth, ScreenHeight / 4.6) animationDuration:2];
    NSMutableArray *viewArray = [@[]mutableCopy];
    NSLog(@"%lu",_carouselArray.count);
    for (int i= 0; i < _carouselArray.count; ++ i) {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_cycleScrollView.bounds];
    //imageView.backgroundColor = [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>]
        
        HeadlinesModel *model = _carouselArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, _cycleScrollView.frame.size.height- 40, _cycleScrollView.frame.size.width - 100, 21)];
        label.text = model.title;
        label.textColor = [UIColor whiteColor];
    //[viewArray addObject:label];
        [imageView addSubview:label];
        [viewArray addObject:imageView];
    }
    [self.headerView addSubview:_cycleScrollView];
    
    _cycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex) {
//        NSLog(@"%ld",pageIndex);
        return viewArray[pageIndex];
    };
    _cycleScrollView.totalPagesCount = viewArray.count;
    __weak NSArray *cycelArray = _carouselArray;
    __block TouTiaoTableViewController *tou = self;
//    __weak ReadViewController *readVC = self;  ps:跳转视图  ps
    _cycleScrollView.TapActionBlock = ^(NSInteger pageIndex) {
//        NSLog(@"点击了第%ld个",(long)pageIndex);
        HeadlinesModel *headlines = [cycelArray objectAtIndex:pageIndex];
//         NSLog(@"url = %@",headlines.url);
        if ([headlines.tag isEqualToString:@"photoset"]) {
            [tou pushPhoto:headlines.url];
        } else {
          NewsDetailViewController *news =   [[NewsDetailViewController alloc]init];
            news.replyid = headlines.docid;
            [tou.myNav pushViewController:news animated:YES];
        }
//        NSLog(@"tag = %@",headlines.tag);
    };
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([NSStringFromClass([self.dataArray[indexPath.row] class]) isEqualToString:@"NewModel"]) {
        return 100;
    } else if ([NSStringFromClass([self.dataArray[indexPath.row] class]) isEqualToString:@"PhotoModel"] ) {
        return 135;
    }else {
        return 165;
    }
    }


- (void)viewDidLoad {
    [super viewDidLoad];
    _start = 0;
    [self requestData];
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight / 4.6)];
    self.tableView.tableHeaderView =self.headerView;
    
    
    self.myNav = self.navigationController;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([NewModel class])];
     [self.tableView registerNib:[UINib nibWithNibName:@"PpliveModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PpliveModel class])];
     [self.tableView registerNib:[UINib nibWithNibName:@"PhotoModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PhotoModel class])];
     [self.tableView registerNib:[UINib nibWithNibName:@"BigPhotoModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([BigPhotoModel class])];
//    self.view.userInteractionEnabled = YES;
   
    [self setupRefresh];
    
}

- (void)setupRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}
-(void)loadNewTopics {
    _start = 0;
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    [self requestData];
}
-(void)loadMoreTopics {
    _start += 10;
    NSLog(@"%ld",_start);
    [self.tableView.mj_footer endRefreshing];
    [self requestData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
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
    
    NewModel *model = self.dataArray[indexPath.row];
    
    
    if ([model.skipType isEqualToString:@"photoset"]) {
        
        [self pushPhoto:model.skipID];
    }else {
      
    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]initWithNibName:@"NewsDetailViewController" bundle:nil];
    newsDetailVC.replyid = model.docid;
    [self.myNav pushViewController:newsDetailVC animated:YES];
    }
//        if (model1.replyid != nil && self.push != nil)  {
//            self.push(model1.replyid);
//        }
}

-(NSMutableArray *)photos {
    if (!_photos) {
        self.photos = [NSMutableArray array];
    }
    return _photos;
}
-(void)pushPhoto:(NSString *)skipID {

    NSArray *list = [skipID componentsSeparatedByString:@"|"];
    if (list.count < 2) {
        return;
    } else {
    
        NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[list[0] substringFromIndex:4],list[1]];
//        NSLog(@"%@",urlStr);
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@",responseObject);
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
//            NSLog(@"%@",dataDic);
            MWPhoto *photo;
            if (self.photos != nil) {
                [self.photos removeAllObjects];
            }
            for (NSDictionary *dic in dataDic[@"photos"]) {
                photo = [MWPhoto photoWithURL:[NSURL URLWithString:dic[@"imgurl"]]];
                photo.caption = dic[@"note"];
                [self.photos addObject:photo];
            }
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.displayActionButton = YES;
//            browser.displayNavArrows = NO;
//            browser.displaySelectionButtons = NO;
//            browser.alwaysShowControls = NO;
            browser.zoomPhotosToFill = YES;
//            browser.enableGrid = NO;
//            browser.startOnGrid = NO;
//            browser.enableSwipeToDismiss = NO;
//            browser.autoPlayOnAppear = NO;
            [browser setCurrentPhotoIndex:0];
            
            [self.myNav pushViewController:browser animated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
         }
    
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
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
