//
//  Get.m
//  WYnewsss
//
//  Created by lanou on 16/4/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "Get.h"
#import "TopicDetailModel.h"
#import "TopicQuestionModel.h"
#import "TopicAnswerModel.h"
#import <MJExtension.h>
#import "NetWorking.h"





@implementation Get




+ (void)getTopicNewsDetailWithExpertId:(NSString *)expertId :(BOOL)isNewQues :(NSInteger)pageCount :(void (^)(NSMutableArray *))complete
{
    if (isNewQues) {
        [self getTopicNewsLateDetailWithExpertId:expertId :pageCount :complete];
    } else {
        [self getTopicNewsHotDetailWithExpertId:expertId :pageCount :complete];
    }
}

+ (void)getTopicNewsHotDetailWithExpertId:(NSString *)expertId :(NSInteger)pageCount :(void (^)(NSMutableArray *))complete
{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/latestqa/%@/%ld0-10.html",expertId,pageCount];
    [NetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        NSMutableArray *quesAnsArray = [NSMutableArray array];
        for (NSDictionary *quesAnsDic in responseObject[@"data"]) {
            TopicDetailModel *item = [[TopicDetailModel alloc] init];
            item.question = [TopicQuestionModel mj_objectWithKeyValues:quesAnsDic[@"question"]];
            item.answer = [TopicAnswerModel mj_objectWithKeyValues:quesAnsDic[@"answer"]];
            [quesAnsArray addObject:item];
        }
        complete(quesAnsArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

+ (void)getTopicNewsLateDetailWithExpertId:(NSString *)expertId :(NSInteger)pageCount :(void (^)(NSMutableArray *))complete
{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/newstopic/list/latestqa/%@/%ld0-10.html",expertId,pageCount+1];
    [NetWorking GET:urlStr parameters:nil progress:^(NSProgress *progress) {
    } success:^(id responseObject, NSURLSessionDataTask *task) {
        NSMutableArray *quesAnsArray = [NSMutableArray array];
        for (NSDictionary *quesAnsDic in responseObject[@"data"]) {
            TopicDetailModel *item = [[TopicDetailModel alloc] init];
            item.question = [TopicQuestionModel mj_objectWithKeyValues:quesAnsDic[@"question"]];
            item.answer = [TopicAnswerModel mj_objectWithKeyValues:quesAnsDic[@"answer"]];
            [quesAnsArray addObject:item];
        }
        complete(quesAnsArray);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
