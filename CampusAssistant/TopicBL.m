//
//  TopicBL.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "TopicBL.h"
#import "MJExtension.h"

@implementation TopicBL

-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.request = [[MyRequest alloc] init];
        self.request.delegate = self;
        self.flag = true;
    }
    return self;
}

-(void)getTopicList{
    _flag = YES;
    [self.request sendRequestWithPath:kFindTopicListPath andParams:nil forMethod:kGet];
   
}

-(void)publishTopicWithUserId:(NSString *)userId andContent:(NSString *)content{
    _flag = NO;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userId forKey:@"userId"];
    [params setObject:content forKey:@"topicContent"];
    
    [self.request sendRequestWithPath:kFindTopicPublishPath andParams:params forMethod:kPost];
}

#pragma mark - request要求实现的方法
-(void)requestBegin{
    if (_flag) {
        [self.delegate getTopicListBegin];
    }else{
        [self.delegate publishTopicBegin];
    }
}

-(void)requestFailed:(NSError *)error{
    if (_flag) {
        [self.delegate getTopicListFailed:error.description];
    }else{
        [self.delegate publishTopicFailed:error.description];
    }
}

-(void)requestSuccessWithMsg:(NSString *)msg{
    if (_flag) {
        [self.delegate getTopicListSuccessWithMsg:msg];
    }else{
        [self.delegate publishTopicSuccessWithMsg:msg];
    }
}

-(void)requestSuccess:(NSDictionary *)dic{
    if (_flag) {
        NSArray* topicArray = [dic objectForKey:@"topicList"];
        NSString* count = [dic objectForKey:@"count"];
        
        NSArray* topicList = [TopicModel objectArrayWithKeyValuesArray:topicArray];
        
        if ([topicList count] == 0) {
            [self.delegate getTopicListSuccessWithMsg:@"还没有人发表话题哦,快点击右上角按钮发表第一个话题吧!"];
        }else{
            [self.delegate getTopicListSuccess:topicList andCount:count.intValue];
        }
    }else{
        [self.delegate publishTopicSuccess];
    }
    
    
}

@end
