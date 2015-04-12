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
    [self.request sendRequestWithPath:kFindTopicListPath andParams:nil forMethod:kGet];
    
   
}


#pragma mark - request要求实现的方法
-(void)requestBegin{
    [self.delegate getTopicListBegin];
}

-(void)requestFailed:(NSError *)error{
    [self.delegate getTopicListFailed:error.description];
}

-(void)requestSuccessWithMsg:(NSString *)msg{
    [self.delegate getTopicListSuccessWithMsg:msg];
}

-(void)requestSuccess:(NSDictionary *)dic{
    NSArray* topicArray = [dic objectForKey:@"topicList"];
    NSString* count = [dic objectForKey:@"count"];
    
    NSArray* topicList = [TopicModel objectArrayWithKeyValuesArray:topicArray];
    
    [self.delegate getTopicListSuccess:topicList andCount:count.intValue];
}

@end
