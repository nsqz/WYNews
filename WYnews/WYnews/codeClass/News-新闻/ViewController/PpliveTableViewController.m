//
//  PpliveTableViewController.m
//  WYnews
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "PpliveTableViewController.h"

#import "PpliveModel.h"
#import "FactoryTableViewCell.h"

@interface PpliveTableViewController ()

@property (nonatomic, strong)NSMutableDictionary *dataDic;

@property (nonatomic, strong)NSMutableArray *KeyArray;

@property (nonatomic, strong)UIView *headerView;

@property (nonatomic, strong)PpliveModel *headModel;

@end

@implementation PpliveTableViewController

-(NSMutableDictionary *)dataDic {

    if (!_dataDic) {
        self.dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
    
}
-(NSMutableArray *)KeyArray {
    if (!_KeyArray) {
        self.KeyArray = [NSMutableArray array];
    }
    return _KeyArray;
}

-(void)requestData {
    NSURLSessionConfiguration*configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL*URL = [NSURL URLWithString:@"http://c.m.163.com/nc/live/livelist/addlocallive/6Zi%2F5Z2d.html"];
    NSURLRequest*request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask*dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse*response,id responseObject,NSError*error) {
        if  (error) {
            NSLog(@"Error:%@", error);
        }else
        {
//                        NSLog(@"%@", responseObject);
           self.headModel = [[PpliveModel alloc]init];
            [self.headModel setValuesForKeysWithDictionary:[responseObject[@"head"] lastObject]];
//            NSLog(_headerView)
            
            for (NSDictionary *dict in responseObject[@"articleList"])
            {
                
                NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
                
                for (NSDictionary *dic in dict[@"list"])
                {
                    
                    PpliveModel *ppLive = [[PpliveModel alloc]init];
                    [ppLive setValuesForKeysWithDictionary:dic];
                    [array addObject:ppLive];
//                    NSLog(@"%@",NSStringFromClass([ppLive class]));
                }
                [self.KeyArray addObject:dict[@"name"]];
                [self.dataDic setObject:array forKey:dict[@"name"]];
            }
          
//            NSLog(@"%ld %ld %ld",self.dataDic.count,[_dataDic[@"正在直播"] count],[_dataDic[@"直播预告"] count]);
            [self.tableView reloadData];
            [self creatHeaderView];
        }
    }];
    
    [dataTask resume];
    
}
-(void)creatHeaderView {
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/4.6)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:View.bounds];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.headModel.imgsrc]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, View.frame.size.height- 40, View.frame.size.width - 100, 21)];
    label.text = self.headModel.title;
    label.textColor = [UIColor whiteColor];
    NSLog(@"%@ ,%@",self.headModel.title,self.headModel.imgsrc);
    //        [viewArray addObject:label];
    [imageView addSubview:label];
    [View addSubview:imageView];
    
    [self.headerView addSubview:View];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight / 4.6)];
    self.tableView.tableHeaderView =self.headerView;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PpliveModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([PpliveModel class])];
    
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 1000;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return _dataDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    switch (section) {
//        case 0:
//            return [_dataDic[@"正在直播"] count];
//            break;
//        case 1:
//            return [_dataDic[@"直播预告"] count];
//            break;
//        case 2:
//            return [_dataDic[@"直播回顾"] count];
//            break;
//        default:
//            return 0;
//            break;
//    }

    return [self.dataDic[self.KeyArray[section]] count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSArray *key = [self.dataDic allKeys];
    NSString *keyStr = self.KeyArray[indexPath.section];
    
    NSArray *array =   self.dataDic[keyStr];
    BaseModel *model =  array[indexPath.row];
//     NSLog(@"%@")  
//    BaseModel *model = self.dataDic[key[indexPath.section]][indexPath.row];
//    NSLog(@"%@",NSStringFromClass([model class]));
    BaseTableViewCell *cell = [FactoryTableViewCell creatTableViewCell:model withTableView:tableView andIndexPath:indexPath];
    
    [cell setDataWithModel:model];
    // Configure the cell...
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.KeyArray[section];
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}
//-()
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
