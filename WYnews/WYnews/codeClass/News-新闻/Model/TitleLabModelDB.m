//
//  TitleLabModelDB.m
//  WYnews
//
//  Created by lanou on 16/4/27.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "TitleLabModelDB.h"

@implementation TitleLabModelDB

- (id) init {
    self = [super init];
    if (self) {
        
        _dataBase = [DBManager defaultDBManager:@"wynews.sqlite"].dataBase;
        _sqlAddress = HEADLINES;
    }
    return self;
}

//  创建数据表
- (void)createDataTable {
    // 查询数据表中元素个数
    FMResultSet * set = [_dataBase executeQuery:[NSString stringWithFormat:@"select count(*) from sqlite_master where type ='table' and name = '%@'", _sqlAddress]];
    [set next];
    NSInteger count = [set intForColumnIndex:0];
    if (count) {
        NSLog(@"数据表已经存在");
    } else {
        // 创建新的数据表
        NSString * sql = [NSString stringWithFormat:@"CREATE TABLE %@ (titleID INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL, ename text, tname text, tid text  )", _sqlAddress];
        BOOL res = [_dataBase executeUpdate:sql];
        if (!res) {
            NSLog(@"数据表创建成功");
        } else {
            NSLog(@"数据表创建失败");
        }
    }
}
//  插入一条数据
- (void) saveDetailModel:(TitleLabModel *)titleLabModel {
    // 创建插入语句
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO %@ (ename,tname,tid) values (?,?,?)", _sqlAddress];
    // 创建插入内容
    NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:0];
    
    if (titleLabModel.ename) {
        [arguments addObject:titleLabModel.ename];
    }
    if (titleLabModel.tname) {
        [arguments addObject:titleLabModel.tname];
    }
    if (titleLabModel.tid) {
        [arguments addObject:titleLabModel.tid];
    }
       NSLog(@"%@",query);
    NSLog(@"添加一条数据");
    // 执行语句
    [_dataBase executeUpdate:query withArgumentsInArray:arguments];
}

//  删除一条数据
- (void) deleteDetailWithTitle:(NSString *)tname {
    NSString * query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE tname = '%@'", _sqlAddress, tname];
    NSLog(@"删除成功");
    [_dataBase executeUpdate:query];
}

//删除所有
- (void)deleteAllTitle {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM %@",_sqlAddress];
    NSLog(@"删除所有");
    [_dataBase executeQuery:query];
}


//  查询所有数据
- (NSArray *)findDB {
    NSString * query = [NSString stringWithFormat:@"SELECT * FROM %@'", _sqlAddress];
    FMResultSet * rs = [_dataBase executeQuery:query];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
    
    while ([rs next]) {
        TitleLabModel * titleLabModel = [[TitleLabModel alloc] init];
        titleLabModel.tname = [rs stringForColumn:@"tname"];
        titleLabModel.ename = [rs stringForColumn:@"ename"];
        titleLabModel.tid = [rs stringForColumn:@"tid"];
        [array addObject:titleLabModel];
    }
    [rs close];
    return array;
}


@end
