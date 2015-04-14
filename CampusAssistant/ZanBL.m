//
//  ZanBL.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ZanBL.h"

@implementation ZanBL

-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.request = [[MyRequest alloc] init];
        self.request.delegate = self;
    }
    return self;
}

-(void)zanWithUserId:(NSString *)userId andTopicId:(int)topicId{
    NSString *topicIdStr = [NSString stringWithFormat:@"%i",topicId];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:userId forKey:@"userId"];
    [params setObject:topicIdStr forKey:@"topicId"];
    
    [self.request sendRequestWithPath:kFindZanPublishPath andParams:params forMethod:kPost];
}


#pragma mark - RequestDelegate要求实现的方法
-(void)requestBegin{
    [self.delegate publishZanBegin];
}

-(void)requestFailed:(NSError *)error{
    [self.delegate publishZanFailed:error.description];
}

-(void)requestSuccess:(NSDictionary *)dic{
    [self.delegate publishZanSuccess];
}

-(void)requestSuccessWithMsg:(NSString *)msg{
    [self.delegate publishZanSuccessWithMsg:msg];
}
@end
