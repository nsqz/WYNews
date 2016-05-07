//
//  MyNewsViewController.m
//  WYnews
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "MyNewsViewController.h"

#import "GirlTableViewController.h"
#import "TouTiaoTableViewController.h"
#import "PpliveTableViewController.h"
#import "ShadeView.h"
#import "TitleLabModel.h"
#import "NetWorkRequestManager.h"
#import "NewsDetailViewController.h"
#import "DateClass.h"
#import "SearchViewController.h"
#import "TitleLabModelDB.h"


@interface MyNewsViewController ()

@property (nonatomic)CAPSPageMenu *pageMenu;

@property (nonatomic)BOOL isOpen; //开关按钮

@property (nonatomic, strong)ShadeView *shade;

@property (nonatomic, strong)NSMutableArray *titleArray; //模型数组
@property (nonatomic, strong)NSMutableArray *controllerArray; //视图数组



@end

@implementation MyNewsViewController


/*
-(NSMutableArray *)titleArray {
    if (_titleArray == nil) {
        self.titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
*/


-(NSMutableArray *)controllerArray {
    if (_controllerArray == nil) {
        TouTiaoTableViewController *toutiaoTVC = [[TouTiaoTableViewController alloc]initWithNibName:@"TouTiaoTableViewController" bundle:nil];
        toutiaoTVC.title =@"头条";
        toutiaoTVC.runGet = nil;
        self.controllerArray = [NSMutableArray arrayWithObject:toutiaoTVC];
        [self addChildViewController:toutiaoTVC];
        /**
         *  测试
         */
//        NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc]initWithNibName:@"NewsDetailViewController" bundle:nil];
//        newsDetailVC.replyid = @"BLM4V40M00031H2L";
//        self.controllerArray = [NSMutableArray arrayWithObject:newsDetailVC];
    }
    return _controllerArray;
}

-(void)requestData {
    NSURLSessionConfiguration*configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURL*URL = [NSURL URLWithString:@"http://c.m.163.com/nc/topicset/ios/subscribe/manage/listspecial.html"];
    NSURLRequest*request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask*dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse*response,id responseObject,NSError*error) {
        if  (error) {
            NSLog(@"Error:%@", error);
        }else
        {
            
        for (NSDictionary *dic in responseObject[@"tList"]) {
            TitleLabModel *model = [[TitleLabModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.titleArray addObject:model];
            
            
            
                            //             1、添加方法
            if ([model.tname isEqualToString:@"美女"] ||  [model.tname isEqualToString:@"型男"] || [model.tname isEqualToString:@"萌宠"]) {
                GirlTableViewController *girlTVC = [[GirlTableViewController alloc]initWithNibName:@"GirlTableViewController" bundle:nil];
                    girlTVC.title = model.tname;
                girlTVC.runGet = model.tid;
                [self.controllerArray addObject:girlTVC];
                [self addChildViewController:girlTVC];
            } else if ([model.tname isEqualToString:@"直播"]) {
                PpliveTableViewController *ppliveTVC = [[PpliveTableViewController alloc]initWithNibName:@"PpliveTableViewController" bundle:nil];
                    ppliveTVC.title = model.tname;
                ppliveTVC.runGet = model.tid;
                [self.controllerArray addObject:ppliveTVC];
                [self addChildViewController:ppliveTVC];
            } else if ([model.tname isEqualToString:@"网易号"]) {
            
            }else if ([model.tname isEqualToString:@"段子"]) {
                GirlTableViewController *duanziTVC = [[GirlTableViewController alloc]initWithNibName:@"GirlTableViewController" bundle:nil];
                    duanziTVC.title = model.tname;
                duanziTVC.runGet = model.ename;
                [self.controllerArray addObject:duanziTVC];
                duanziTVC.runGet = model.tid;
                [self addChildViewController:duanziTVC];
            } else if ([model.tname isEqualToString:@"图片"]) {
            
            }else if([model.tname isEqualToString:@"头条"]) {
            
            }else {
                TouTiaoTableViewController *toutiaoTVC = [[TouTiaoTableViewController alloc]initWithNibName:@"TouTiaoTableViewController" bundle:nil];
                    toutiaoTVC.title = model.tname;
                [self.controllerArray addObject:toutiaoTVC];
                toutiaoTVC.runGet = model.tid;
                [self addChildViewController:toutiaoTVC];
            }
 

            
                }
      
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self addTitleModelAndDB];
            NSDictionary *parameters = @{
                                         
                                                                          CAPSPageMenuOptionSelectionIndicatorColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0],
                                                                          CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
                                                                          CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor redColor],
                                                                          CAPSPageMenuOptionMenuHeight: @(30),
                                                                          CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor blackColor],
                                                                          CAPSPageMenuOptionMenuItemWidth:@(ScreenWidth/5)
                                                                          };
                                             
                                             
                                             _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:self.controllerArray frame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
                                             [self.view addSubview:_pageMenu.view];
                [self createEditBtn];

                                         });
         
        }
            
    }];
    
    [dataTask resume];
    
}/*
*/
/*
-(void)addTitleModelAndDB {

    
    TitleLabModelDB *db = [[TitleLabModelDB alloc]init];
    [db createDataTable];
//    NSArray *array = [db findDB];
    for (TitleLabModel *model in self.titleArray) {
        if ([model.tname isEqualToString:@"图片"]||[model.tname isEqualToString:@"头条"]||[model.tname isEqualToString:@"网易号"]||[model.tname isEqualToString:@"态度公开课"]) {
            
        } else {
            [db saveDetailModel:model];
        }
    }
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(9, 1, 1) lastObject]);
}
*/

//- (void)addTitleVC {
//    for (TitleLabModel *model in self.) {
//        if ([model.tname isEqualToString:@"美女"] ||  [model.tname isEqualToString:@"型男"] || [model.tname isEqualToString:@"萌宠"]) {
//            GirlTableViewController *girlTVC = [[GirlTableViewController alloc]initWithNibName:@"GirlTableViewController" bundle:nil];
//            girlTVC.title = model.tname;
//            girlTVC.runGet = model.tid;
//            [self.controllerArray addObject:girlTVC];
//            [self addChildViewController:girlTVC];
//        } else if ([model.tname isEqualToString:@"直播"]) {
//            PpliveTableViewController *ppliveTVC = [[PpliveTableViewController alloc]initWithNibName:@"PpliveTableViewController" bundle:nil];
//            ppliveTVC.title = model.tname;
//            ppliveTVC.runGet = model.tid;
//            [self.controllerArray addObject:ppliveTVC];
//            [self addChildViewController:ppliveTVC];
//        } else if ([model.tname isEqualToString:@"网易号"]) {
//            
//        }else if ([model.tname isEqualToString:@"段子"]) {
//            GirlTableViewController *duanziTVC = [[GirlTableViewController alloc]initWithNibName:@"GirlTableViewController" bundle:nil];
//            duanziTVC.title = model.tname;
//            duanziTVC.runGet = model.ename;
//            [self.controllerArray addObject:duanziTVC];
//            duanziTVC.runGet = model.tid;
//            [self addChildViewController:duanziTVC];
//        } else if ([model.tname isEqualToString:@"图片"]) {
//            
//        }else if([model.tname isEqualToString:@"头条"]) {
//            
//        }else {
//            TouTiaoTableViewController *toutiaoTVC = [[TouTiaoTableViewController alloc]initWithNibName:@"TouTiaoTableViewController" bundle:nil];
//            toutiaoTVC.title = model.tname;
//            [self.controllerArray addObject:toutiaoTVC];
//            toutiaoTVC.runGet = model.tid;
//            [self addChildViewController:toutiaoTVC];
//        }
//    }
//   
//}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _isOpen = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationItem.hidesBackButton = NO;
    [self requestData];
    [self setupNav];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(push)];
//    self.navigationItem.rightBarButtonItem = item;
    /*
    TouTiaoTableViewController *toutiaoTVC = [[TouTiaoTableViewController alloc]initWithNibName:@"TouTiaoTableViewController" bundle:nil];
    toutiaoTVC.title = @"头条";
    
    GirlTableViewController *girlTVC = [[GirlTableViewController alloc]initWithNibName:@"GirlTableViewController" bundle:nil];
    girlTVC.title = @"美女";
    girlTVC.runGet = @"T1456112189138";
    
    GirlTableViewController *duanziTVC = [[GirlTableViewController alloc]initWithNibName:@"GirlTableViewController" bundle:nil];
    duanziTVC.title = @"段子";
    duanziTVC.runGet = @"duanzi";
    PpliveTableViewController *ppliveTVC = [[PpliveTableViewController alloc]initWithNibName:@"PpliveTableViewController" bundle:nil];
    ppliveTVC.title = @"直播";
    

    
    NSArray *controllerArray = @[toutiaoTVC, girlTVC, duanziTVC, ppliveTVC];
    
    NSDictionary *parameters = @{

                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0],
                                 CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor redColor],
                                 CAPSPageMenuOptionMenuHeight: @(30),
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor blackColor],
                                 CAPSPageMenuOptionMenuItemWidth:@(ScreenWidth/5)
                                 };
    
    
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
    [self.view addSubview:_pageMenu.view];
    */
    
//    [self createShadeView];
    // Do any additional setup after loading the view from its nib.
    
//    NSDictionary *parameters = @{
//                                 
//                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0],
//                                 CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
//                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor redColor],
//                                 CAPSPageMenuOptionMenuHeight: @(30),
//                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor blackColor],
//                                 CAPSPageMenuOptionMenuItemWidth:@(ScreenWidth/5)
//                                 };
//    
//    
//    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:self.controllerArray frame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
//    [self.view addSubview:_pageMenu.view];

//    [self createEditBtn];
}

//创建视图添加按钮
-(void)createEditBtn {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake( ScreenWidth - 36, 63,36, 36)];
    UIButton *editBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    editBtn.frame = view.bounds;
//    editBtn.titleLabel.text = @"+";
    editBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [editBtn setTitle:@"+" forState:(UIControlStateNormal)];
    [editBtn addTarget:self action:@selector(openView:) forControlEvents:(UIControlEventTouchUpInside)];
//    editBtn.titleLabel.textColor = [UIColor blackColor];
    [view addSubview:editBtn];
    [self.view addSubview:view];
}

-(void)openView:(UIButton *)editBtn {
    
    if (_isOpen) {
        
        [UIView animateWithDuration:1.0 animations:^{
            editBtn.transform = CGAffineTransformMakeRotation(0);
        }];
        
        _isOpen = NO;
    } else {
        
        [UIView animateWithDuration:1.0 animations:^{
            editBtn.transform = CGAffineTransformMakeRotation(M_PI_4);
        }];
        
        
        _isOpen = YES;
    }


}

//创建视图 -----ps:不可行
/*
-(void)createShadeView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 36)];
    NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"ShadeView" owner:nil options:nil];
    _shade = [views lastObject];
    _shade.frame =view.bounds;
    view.backgroundColor = [UIColor clearColor];
//    NSLog(@"%@",NSStringFromCGRect(_shade.frame));
    _shade.ShadeOpen = ^() {
        NSLog(@"打开");
    };
    self.view.userInteractionEnabled = YES;
    [view addSubview:_shade];
    [self.view addSubview:view];
    
}
*/


- (void)setupNav {
    
    self.navigationItem.title = @"新闻";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"search_icon" hightImage:@"search_icon" target:self action:@selector(tagClick)];
    
//    self.view.backgroundColor = [UIColor orangeColor];
    
}

- (void)tagClick {
    SearchViewController *tags = [[SearchViewController alloc] init];
    [self.navigationController presentViewController:tags animated:YES completion:nil];
}

- (void)didTapGoToLeft {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex > 0) {
        [_pageMenu moveToPage:currentIndex - 1];
    }
}

- (void)didTapGoToRight {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex < self.pageMenu.controllerArray.count) {
        [self.pageMenu moveToPage:currentIndex + 1];
    }
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
