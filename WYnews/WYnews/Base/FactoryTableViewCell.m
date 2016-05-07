//
//  FactoryTableViewCell.m
//  WYnews
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "FactoryTableViewCell.h"

@implementation FactoryTableViewCell

+(BaseTableViewCell *)creatTableViewCell:(BaseModel *)model {
    //1、将model类名转成字符串
    NSString *name = NSStringFromClass([model class]);
    
    //2、获取要创建的cell的类名
    Class cellClass= NSClassFromString([NSString stringWithFormat:@"%@Cell",name]);
    
    //根据cell 创建对象
    BaseTableViewCell *cell = [[cellClass alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:name];
    
    //返回
    return cell;
}

+(BaseTableViewCell *)creatTableViewCell:(BaseModel *)model withTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *name = NSStringFromClass([model class]);
    
//        Class cellClasee = NSClassFromString([NSString stringWithFormat:@"%@Cell",name]);
//    NSLog(@"%@",name);
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name forIndexPath:indexPath];
    
    return cell;
    
}


@end
