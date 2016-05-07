//
//  TitleLabModelDB.h
//  WYnews
//
//  Created by lanou on 16/4/27.
//  Copyright © 2016年 hl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
#import "TitleLabModel.h"
#import "FMDB.h"


@interface TitleLabModelDB : NSObject

@property (nonatomic, strong) FMDatabase *dataBase;
@property (nonatomic, copy)NSString *sqlAddress;

//  创建数据表
- (void)createDataTable;
//  插入一条数据
- (void) saveDetailModel:(TitleLabModel *)detailModel;
//  删除一条数据
- (void) deleteDetailWithTitle:(NSString *)detailTitle;
//  查询所有数据
- (NSArray *)findDB;
//删除所有
- (void)deleteAllTitle;

@end
