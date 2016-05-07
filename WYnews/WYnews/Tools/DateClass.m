//
//  DateClass.m
//  WYnews
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "DateClass.h"

@implementation DateClass
+(NSString *)GetBeijingTime:(DateAlways)dateAlways {

        NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
//    NSLog(@"dateString:%@",dateString);
 
    NSArray *list = [dateString componentsSeparatedByString:@" "];//空格分隔字符串
    NSArray *list1 = [list[0] componentsSeparatedByString:@"-"];
    switch (dateAlways) {
        case DATE:
            return list[0];
            break;
        case always:
            return list[1];
            break;
        case complete:
            return dateString;
            break;
        case Day:
            return [list1 lastObject];
            break;
        case month:
            return list1[1];
            break;
        default:
            return nil;
            break;
    }
    
}

+(NSInteger )TimeByDay:(NSString *)time {
    
    NSArray *list = [time componentsSeparatedByString:@" "];//空格分隔字符串
    NSArray *list1 = [[list firstObject] componentsSeparatedByString:@"-"];
    
    NSInteger   sum =  0;
    if (list1.count < 2) {
//        NSLog(@"%ld",list1.count);
//        NSLog(@"list = %@",list1);
        return 0;
    }
   NSInteger year = [list1[0] integerValue];
    NSInteger month = [list1[1] integerValue];
    NSInteger day = [list1[2] integerValue];
    
    switch(month)
    {
        case 1:sum=0;break;
        case 2:sum=31;break;
        case 3:sum=59;break;
        case 4:sum=90;break;
        case 5:sum=120;break;
        case 6:sum=151;break;
        case 7:sum=181;break;
        case 8:sum=212;break;
        case 9:sum=243;break;
        case 10:sum=273;break;
        case 11:sum=304;break;
        case 12:sum=334;break;
        default:printf("data error");
            break;
    }
    sum=sum+day;
    NSInteger leap = 0;
    if(year%400==0||(year%4==0&&year%100!=0))
        leap=1;
    else
        leap=0;
    if(leap==1&&month>2)
        sum++;
//    printf("It is the %ldth day.",sum);

    return sum;
}

+(NSString *)getTime:(long)second {
    NSDate *date = [NSDate date];
    NSDate *a = [date initWithTimeIntervalSince1970:second];
    NSString *time = [a descriptionWithLocale:@" "];
    NSString *timeS = [time substringToIndex:10];
    return timeS;
}

@end
