//
//  NewsDetailViewController.m
//  WYnews
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "NewsDetailViewController.h"

#import "ImgModel.h"
#import "StrFontModel.h"
#import "VotesModel.h"
#import "VideoModel.h"
#import "NewDetailModel.h"
#import "VoteitemModel.h"
#import "RewardsModel.h"
#import "FactoryTableViewCell.h"
#import "WMPlayer.h"
#import "VideoModelCell.h"
#import "MWPhotoBrowser.h"

@interface NewsDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MWPhotoBrowserDelegate>{
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
    WMPlayer *wmPlayer ;
}

@property (weak, nonatomic) IBOutlet UITableView *DatailTVC;

@property (nonatomic, strong)NewDetailModel *model;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)UIView *headerView;

@property(nonatomic,retain)VideoModelCell *currentCell;

@property (nonatomic, strong)NSMutableArray *photos;//

@end

@implementation NewsDetailViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        isSmallScreen = NO;
    }
    return self;
}

//是否播放
-(BOOL)prefersStatusBarHidden{
    if (wmPlayer) {
        if (wmPlayer.isFullscreen) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}
-(void)videoDidFinished:(NSNotification *)notice{
    VideoModelCell *currentCell = (VideoModelCell *)[self.DatailTVC cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
}

//关闭视频
-(void)closeTheVideo:(NSNotification *)obj{
    VideoModelCell *currentCell = (VideoModelCell *)[self.DatailTVC cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)fullScreenBtnClick:(NSNotification *)notice{
    UIButton *fullScreenBtn = (UIButton *)[notice object];
    if (fullScreenBtn.isSelected) {//全屏显示
        wmPlayer.isFullscreen = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        if (isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (wmPlayer.isFullscreen) {
                if (isSmallScreen) {
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }else{
                    [self toCell];
                }
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            if (wmPlayer.isFullscreen == NO) {
                wmPlayer.isFullscreen = YES;
                
                [self setNeedsStatusBarAppearanceUpdate];
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            if (wmPlayer.isFullscreen == NO) {
                wmPlayer.isFullscreen = YES;
                [self setNeedsStatusBarAppearanceUpdate];
                [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
            }
        }
            break;
        default:
            break;
    }
}

-(void)toCell{
    VideoModelCell *currentCell = (VideoModelCell *)[self.DatailTVC cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [wmPlayer removeFromSuperview];
    NSLog(@"row = %ld",currentIndexPath.row);
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = currentCell.videoView.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [currentCell.videoView addSubview:wmPlayer];
        [currentCell.videoView bringSubviewToFront:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
        }];
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        isSmallScreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        
    }];
    
}
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, ScreenHeight,ScreenWidth);
    
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(ScreenWidth-40);
        make.width.mas_equalTo(ScreenHeight);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmPlayer).with.offset((-ScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
        
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    
    wmPlayer.fullScreenBtn.selected = YES;
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
    
}
-(void)toSmallScreen{
    //放widow上
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = CGRectMake(ScreenWidth/2,ScreenHeight-kTabBarHeight-(ScreenWidth/2)*0.75, ScreenWidth/2, (ScreenWidth/2)*0.75);
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
            
        }];
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        wmPlayer.fullScreenBtn.selected = NO;
        isSmallScreen = YES;
//        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmPlayer];
    }];
    
}


-(NewDetailModel *)model {
    if (!_model) {
        self.model = [[NewDetailModel alloc]init];
    }
    return _model;
}
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)requestData {
    NSString  *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.replyid];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        NSDictionary *dic = dataDic[self.replyid];
        [self.model setValuesForKeysWithDictionary:dic];
        NSMutableArray *imgArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (NSDictionary *img in dic[@"img"]) {
            ImgModel *imgM =  [[ImgModel alloc]init];
            [imgM setValuesForKeysWithDictionary:img];
            [imgArr addObject:imgM];
        }
        
        
        NSMutableArray *votesArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (NSDictionary *votes in dic[@"votes"]) {
            VotesModel *votesM = [[VotesModel alloc]init];
            [votesM setValuesForKeysWithDictionary:votes];
            [votesArr addObject:votesM];
            
            /**
             投票内容
             */
            NSMutableArray *voteitemMArr = [[NSMutableArray alloc]initWithCapacity:0];
            for (NSDictionary *voteitem in votes[@"voteitem"]) {
                VoteitemModel *voteitemM = [[VoteitemModel alloc]init];
                [voteitemM setValuesForKeysWithDictionary:voteitem];
                [voteitemMArr addObject:voteitemM];
            }
            votesM.voteitem = voteitemMArr;
        }
    

        NSMutableArray *videoArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (NSDictionary *video in dic[@"video"]) {
            VideoModel *videoM = [[VideoModel alloc]init];
            [videoM setValuesForKeysWithDictionary:video];
            [videoArr addObject:videoM];
        }
        /**
         编辑
         */
        NSMutableArray *rewardsArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (NSDictionary *reward in dic[@"rewards"]) {
            RewardsModel *rewardsM = [[RewardsModel alloc]init];
            [rewardsM setValuesForKeysWithDictionary:reward];
            [rewardsArr addObject:rewardsM];
        }
        
        self.model.imgArr = imgArr;
        self.model.votesArr = votesArr;
        self.model.videoArr = videoArr;
        self.model.rwardArr = rewardsArr;
//                        NSLog(@"%@", self.model);
        [self productionDataArray];
       

     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"%@",error);
         
     }];
    
}

- (void)productionDataArray {

    NSString *body = self.model.body;
    
    //替换 /p 为 p
    NSString *body1 = [body stringByReplacingOccurrencesOfString:@"</p>" withString:@"<p>"];

    //通过<p>分隔字符串
    NSArray *list = [body1 componentsSeparatedByString:@"<p>"];
   
 
    /**
     *  方法一
     */
     /*
    int i = 0,j = 0, v = 0,r = 0;
    for (NSString *str in list) {
        if (str.length == 0) {
            ;
        }else if ([str rangeOfString:@"<!--IMG"].location != NSNotFound) {
            [self.dataArray addObject:self.model.imgArr[i]];
            i ++;
        }else if ([str rangeOfString:@"<!--@@PKVOTEID"].location != NSNotFound) {
            [self.dataArray addObject:self.model.votesArr[j]];
            j ++;
        }else if ([str rangeOfString:@"<!--@@H1-->"].location != NSNotFound) {
            StrFontModel *strFont = [[StrFontModel alloc]init];
            strFont.content  = [str componentsSeparatedByString:@"<!--@@H1-->"][1];
//            NSLog(@"%@",strFont.content);
            strFont.tagging = subtitle;
            [self.dataArray addObject:strFont];
        }else if ([str rangeOfString:@"<!--VIDEO"].location != NSNotFound) {
            [self.dataArray addObject:self.model.videoArr[v]];
            v ++;
        }else if ([str rangeOfString:@"<!--@@END-->"].location != NSNotFound) {
            StrFontModel *strFont = [[StrFontModel alloc]init];
            strFont.content  = [str componentsSeparatedByString:@"<!--@@END-->"][1];
//            NSLog(@"%@",strFont.content);
            strFont.tagging = quoteText;
            [self.dataArray addObject:strFont];
        } else if ([str rangeOfString:@"<!--REWARD"].location != NSNotFound){
            [self.dataArray addObject:self.model.rwardArr[r]];
            r ++;
        } else if ([str rangeOfString:@"<!--SPINFO"].location != NSNotFound) {
        
        }else if ([str rangeOfString:@"<!--link"].location != NSNotFound ) {
        
        } else if ([str rangeOfString:@"strong>"].location != NSNotFound) {
            StrFontModel *strFont = [[StrFontModel alloc]init];
            NSString *st = [str componentsSeparatedByString:@"strong>"][1];
            if (st.length > 2 ) {
                strFont.content =  [st substringWithRange:NSMakeRange(0, st.length - 2)];
            strFont.tagging = subtitle;
            [self.dataArray addObject:strFont];
            }
            
        } else  if ([str rangeOfString:@"b>"].location != NSNotFound){
            StrFontModel *strFont = [[StrFontModel alloc]init];
            NSArray *list = [str componentsSeparatedByString:@"b>"];
            NSString *st = list[1];
            if (st.length > 2 ) {
                NSString *string = [list componentsJoinedByString:@""];
                NSString *xx = [string stringByReplacingOccurrencesOfString:@"</" withString:@"<"];
                NSString *content = [xx stringByReplacingOccurrencesOfString:@"<" withString:@""];
                strFont.content = content;
//                strFont.content =  [st substringWithRange:NSMakeRange(0, st.length - 2)];
                strFont.tagging = subname;
                    [self.dataArray addObject:strFont];
            }
//            if (list.count > 3) {
//                
//            }
            
        } else if ([str rangeOfString:@"-->"].location != NSNotFound) {
#warning xxxxx ----隔离错误
        } else {
            StrFontModel *strFont = [[StrFontModel alloc]init];
            strFont.content =  [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            strFont.tagging = theText;
            [self.dataArray addObject:strFont];
        }
    }
    */
    
    /*
     方法二 占位符替代
     */
    for (NSString *str in list) {
        if (str.length == 0) {
            ;
        }else if ([str rangeOfString:@"<!--@@H1-->"].location != NSNotFound) {
            StrFontModel *strFont = [[StrFontModel alloc]init];
            strFont.content  = [str componentsSeparatedByString:@"<!--@@H1-->"][1];
            //            NSLog(@"%@",strFont.content);
            strFont.tagging = subtitle;
            [self.dataArray addObject:strFont];
        }  else if ([str rangeOfString:@"-->"].location != NSNotFound) {
#warning xxxxx ----隔离错误  可能有字符串移入
            if ([str rangeOfString:@"<!--IMG"].location != NSNotFound || [str rangeOfString:@"<!--REWARD"].location != NSNotFound || [str rangeOfString:@"<!--VIDEO"].location != NSNotFound || [str rangeOfString:@"<!--@@PKVOTEID"].location != NSNotFound) {
                NSArray *list2 =[str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
                NSInteger cou = list2.count;
                if (cou >= 2) {
                    for (int i = 1; i < cou ; i = i +2) {
                        NSString *px =  [[NSString stringWithFormat:@"<%@>",list2[i]] stringByReplacingOccurrencesOfString:@"/n" withString:@""];
                        
                        if ([px rangeOfString:@"<!"].location != NSNotFound) {
                             [self.dataArray addObject:px];
                        }
                    }
                }            }
            
        }else if ([str rangeOfString:@"strong>"].location != NSNotFound) {
            StrFontModel *strFont = [[StrFontModel alloc]init];
//            NSString *st = [str componentsSeparatedByString:@"strong>"][1];
//            if (st.length > 2 ) {
                strFont.content =  [self filterHTML:str];
                strFont.tagging = subtitle;
                [self.dataArray addObject:strFont];
//            }
        } else  if ([str rangeOfString:@"b>"].location != NSNotFound){
            StrFontModel *strFont = [[StrFontModel alloc]init];
            strFont.content  =  [self filterHTML:str];
            strFont.tagging = subname;
            [self.dataArray addObject:strFont];
//            NSArray *list = [str componentsSeparatedByString:@"b>"];
//            NSString *st = list[1];
//            if (st.length > 2 ) {
//                NSString *string = [list componentsJoinedByString:@""];
//                NSString *xx = [string stringByReplacingOccurrencesOfString:@"</" withString:@"<"];
//                NSString *content = [xx stringByReplacingOccurrencesOfString:@"<" withString:@""];
//                strFont.content = content;
//                strFont.tagging = subname;
//                [self.dataArray addObject:strFont];
//            }
        }  else  {
            StrFontModel *strFont = [[StrFontModel alloc]init];
            strFont.content =  [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            strFont.tagging = theText;
            [self.dataArray addObject:strFont];
        }
    }
    
    for (ImgModel *model in self.model.imgArr) {
        NSUInteger  a=  [self.dataArray indexOfObject:model.ref];
        [self.dataArray replaceObjectAtIndex:a withObject:model];
//        NSLog(@"%lu",a);
    }
    for (VotesModel  *model in self.model.votesArr) {
        NSUInteger a = [self.dataArray indexOfObject:model.ref];
        if (a < self.dataArray.count) {
              [self.dataArray replaceObjectAtIndex:a withObject:model];
        }
    }
    
    for (RewardsModel *model in self.model.rwardArr) {
        NSUInteger a = [self.dataArray indexOfObject:model.ref];
        [self.dataArray replaceObjectAtIndex:a withObject:model];
    }
    for (VideoModel *model in self.model.videoArr) {
        NSUInteger a = [self.dataArray indexOfObject:model.ref];
        [self.dataArray replaceObjectAtIndex:a withObject:model];
    }
    
    NSLog(@"%@,%lu",self.dataArray,self.dataArray.count);
//    [self addFooter];
    [self   creatHeaderView];
    [self.DatailTVC reloadData];
    
    /*
    for (NSString *st in list) {
        NSArray *list1 = [st componentsSeparatedByString:@"--"];
        if (list1.count  > 2) {
            NSLog(@"%@",list[1]);
            if ([list1[1] isEqualToString:@"@@H1"]) {
                StrFontModel *strFont = [[StrFontModel alloc]init];
                strFont.content = [list1[2] substringWithRange:NSMakeRange(1, [list1[2] length]-3)];
                strFont.tagging = subtitle;
                [self.dataArray addObject:strFont];
            } else if ([list1[1] isEqualToString:@"@@END"]) {
                StrFontModel *strFont = [[StrFontModel alloc]init];
                strFont.content = [list1[2] substringWithRange:NSMakeRange(1, [list1[2] length]-3)];
                strFont.tagging = quoteText;
            } else if ([list1[1] rangeOfString:@"IMG"].location !=NSNotFound) {
                
            }
        }
    }
     */
}
//去标签
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:WMPlayerFullScreenButtonClickedNotification object:nil];
    
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeTheVideo:)
                                                 name:WMPlayerClosedNotification
                                               object:nil
     ];

    
    [self.DatailTVC registerNib:[UINib nibWithNibName:@"StrFontModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([StrFontModel class])];
    [self.DatailTVC registerNib:[UINib nibWithNibName:@"RewardsModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([RewardsModel class])];
    [self.DatailTVC registerNib:[UINib nibWithNibName:@"VideoModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([VideoModel class])];
    [self.DatailTVC registerNib:[UINib nibWithNibName:@"VotesModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([VotesModel class])];
    [self.DatailTVC registerNib:[UINib nibWithNibName:@"ImgModelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ImgModel class])];
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, 65)];
    self.DatailTVC.tableHeaderView =self.headerView;
//    self.
//    self.DatailTVC.tableFooterView =
//    self.DatailTVC.style =
    self.DatailTVC.rowHeight = UITableViewAutomaticDimension;
    self.DatailTVC.estimatedRowHeight = 1000;
      // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    BaseModel *model = self.dataArray[indexPath.row];
//    if ([NSStringFromClass([model class])isEqualToString:@"VotesModelCell"]) {
////        NSLog(@"")
//        return 120;
//    }else {
//        return 10;/Users/lanou/Desktop/WYnews/WYnews
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseModel *model = self.dataArray[indexPath.row];
   
    
    BaseTableViewCell *cell = [FactoryTableViewCell creatTableViewCell:model withTableView:tableView andIndexPath:indexPath];
    
        [cell setDataWithModel:model];
    
  
     if ([NSStringFromClass([cell class])isEqualToString:@"VideoModelCell"]) {
         VideoModelCell *cell1 = (VideoModelCell *)cell;
         [cell1.playBtn addTarget:self action:@selector(startPlayVideoB:) forControlEvents:UIControlEventTouchUpInside];
         cell1.playBtn.tag = indexPath.row;
 
         if (wmPlayer&&wmPlayer.superview) {
             if (indexPath.row==currentIndexPath.row) {
                 [cell1.playBtn.superview sendSubviewToBack:cell1.playBtn];
             }else{
                 [cell1.playBtn.superview bringSubviewToFront:cell1.playBtn];
             }
             NSArray *indexpaths = [tableView indexPathsForVisibleRows];
             if (![indexpaths containsObject:currentIndexPath]) {//复用
                 
                 if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]) {
                     wmPlayer.hidden = NO;
                     
                 }else{
                     wmPlayer.hidden = YES;
                     [cell1.playBtn.superview bringSubviewToFront:cell1.playBtn];
                 }
             }else{
                 if ([cell1.videoView.subviews containsObject:wmPlayer]) {
                     [cell1.videoView addSubview:wmPlayer];
                     [wmPlayer play];
                     wmPlayer.playOrPauseBtn.selected = NO;
                     wmPlayer.hidden = NO;
                 }
             }
         }
     }
  
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BaseModel *model = self.dataArray[indexPath.row];
//    NSLog(@"%ld",indexPath.row);
    if ([NSStringFromClass([model class])isEqualToString:@"ImgModel"])
    {
        NSInteger a = [self.model.imgArr indexOfObject:model];
        if (a < self.model.imgArr.count) {
              [self pushPhoto:a];
        }
    }
}
/**/
/*
-(void)startPlayVideo:(NSIndexPath *)indexPath{
    currentIndexPath = indexPath;//[NSIndexPath indexPathForRow:sender.tag inSection:0];
//    NSLog(@"currentIndexPath.row = %ld",currentIndexPath.row);
//    if ([UIDevice currentDevice].systemVersion.floatValue>=8||[UIDevice currentDevice].systemVersion.floatValue<7) {
//        self.currentCell = (VideoModelCell *)sender.superview.superview;
//    }else{//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
//        self.currentCell = (VideoModelCell *)sender.superview.superview.subviews;
//        
//    }
    self.currentCell = [self.DatailTVC cellForRowAtIndexPath:indexPath];
    VideoModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    isSmallScreen = NO;
    
    
    if (wmPlayer) {
        [wmPlayer removeFromSuperview];
        [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
        [wmPlayer setVideoURLStr:model.mp4_url];
        [wmPlayer play];
        
    }else{
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.videoView.bounds videoURLStr:model.m3u8_url];
        [wmPlayer play];
        
    }
    [self.currentCell.videoView addSubview:wmPlayer];
    [self.currentCell.videoView bringSubviewToFront:wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self.DatailTVC reloadData];
    
}
*/

-(void)startPlayVideoB:(UIButton *)sender{
    currentIndexPath =[NSIndexPath indexPathForRow:sender.tag inSection:0];
        NSLog(@"currentIndexPath.row = %ld",currentIndexPath.row);
//        if ([UIDevice currentDevice].systemVersion.floatValue>=8||[UIDevice currentDevice].systemVersion.floatValue<7) {
//            self.currentCell = (VideoModelCell *)sender.superview.superview;
//        }else{//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
//            self.currentCell = (VideoModelCell *)sender.superview.superview.subviews;
//    
//        }
    self.currentCell = [self.DatailTVC cellForRowAtIndexPath:currentIndexPath];
    VideoModel *model = [self.dataArray objectAtIndex:currentIndexPath.row];
    
    isSmallScreen = NO;
    
    
    if (wmPlayer) {
        [wmPlayer removeFromSuperview];
        [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
        [wmPlayer setVideoURLStr:model.m3u8_url];
        [wmPlayer play];
        
    }else{
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.videoView.bounds videoURLStr:model.m3u8_url];
        [wmPlayer play];
        
    }
    [self.currentCell.videoView addSubview:wmPlayer];
    [self.currentCell.videoView bringSubviewToFront:wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self.DatailTVC reloadData];
    
}


//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}
//-(void)addFooter {
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , 30)];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 21)];
//    label.text  = [NSString stringWithFormat:@"[ 责任编辑： %@ ]" ,self.model.ec];
//    label.textAlignment = NSTextAlignmentRight;
//    label.textColor = [UIColor lightGrayColor];
//    label.font = [UIFont systemFontOfSize:15];
//    [view addSubview:label ];
//    view.backgroundColor = [UIColor redColor];
//    [self.DatailTVC.tableFooterView addSubview:view];
//}

-(void)creatHeaderView {
    UIView *View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,65)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, ScreenWidth - 20, 24)];
    label.text = self.model.title;
    label.font = [UIFont boldSystemFontOfSize:23];
    [View addSubview:label];
    
    UILabel *timerLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 42, 120 , 20)];
    timerLbl.text = [self.model.ptime substringFromIndex:5];
    timerLbl.font = [UIFont systemFontOfSize:14];
    [View addSubview:timerLbl];
    
    UILabel *sourceLbl = [[UILabel alloc]initWithFrame:CGRectMake(140, 42, ScreenWidth - 120, 20)];
    sourceLbl.text = self.model.source;
    sourceLbl.font = [UIFont systemFontOfSize:14];
    [View addSubview:sourceLbl];
    
    [self.DatailTVC.tableHeaderView addSubview:View];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.model.ec == nil) {
        return nil;
    }
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 21)];
    label.text  = [NSString stringWithFormat:@"[ 责任编辑： %@ ]" ,self.model.ec];
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label ];
    return view;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 40;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

/**
 *  释放WMPlayer
 */
-(void)releaseWMPlayer{
    [wmPlayer.player.currentItem cancelPendingSeeks];
    [wmPlayer.player.currentItem.asset cancelLoading];
    [wmPlayer pause];
    
    //移除观察者
    [wmPlayer.currentItem removeObserver:wmPlayer forKeyPath:@"status"];
    
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    [wmPlayer.durationTimer invalidate];
    wmPlayer.durationTimer = nil;
    
    
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
    
    currentIndexPath = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self releaseWMPlayer];
}


#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.DatailTVC){
        if (wmPlayer==nil) {
            return;
        }
        
        if (wmPlayer.superview) {
            CGRect rectInTableView = [self.DatailTVC rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.DatailTVC convertRect:rectInTableView toView:[self.DatailTVC superview]];
            if (rectInSuperview.origin.y<-self.currentCell.videoView.frame.size.height||rectInSuperview.origin.y>ScreenHeight-NavigationBarHeight-kTabBarHeight) {//往上拖动
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]&&isSmallScreen) {
                    isSmallScreen = YES;
                }else{
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }
                
            }else{
                if ([self.currentCell.videoView.subviews containsObject:wmPlayer]) {
                    
                }else{
                    [self toCell];
                }
            }
        }
        
    }
}

-(NSMutableArray *)photos{
    if (!_photos) {
        self.photos = [NSMutableArray array];
    }
    return _photos;
}
-(void)pushPhoto:(NSInteger)index {
    MWPhoto *photo;
    if (self.photos.count == 0){
    for (ImgModel *img in self.model.imgArr) {
         {
        photo = [MWPhoto photoWithURL:[NSURL URLWithString:img.src]];
        photo.caption = img.alt;
        [self.photos addObject:photo];
    }
    }
    } 
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
//                browser.displayNavArrows = YES;
//                browser.displaySelectionButtons = YES;
//                browser.alwaysShowControls = YES;
    browser.zoomPhotosToFill = YES;
//                browser.enableGrid = YES;
//                browser.startOnGrid = YES;
//                browser.enableSwipeToDismiss = YES;
//                browser.autoPlayOnAppear = YES;
    [browser setCurrentPhotoIndex:index];
    
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count - 1;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
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
