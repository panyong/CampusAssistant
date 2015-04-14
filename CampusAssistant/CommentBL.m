//
//  CommentBL.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "CommentBL.h"

@implementation CommentBL


-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.request = [[MyRequest alloc] init];
        self.request.delegate = self;
    }
    
    return self;
}

-(void)publishCommentWithTopicId:(int)topicId userId:(NSString*)userId content:(NSString *)content{
    _flag =true;
    
    NSString *topicIdStr = [NSString stringWithFormat:@"%i",topicId];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:topicIdStr forKey:@"topicId"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:content forKey:@"commentContent"];
    
    [self.request sendRequestWithPath:kFindCommentPublishPath andParams:params forMethod:kPost];
}

-(void)getTopicModelById:(int)topicId{
    _flag=false;
    
    NSString *topicIdStr = [NSString stringWithFormat:@"%i",topicId];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:topicIdStr forKey:@"topicId"];
    
    [self.request sendRequestWithPath:kFindTopicDeatiltPath andParams:params forMethod:kGet];
}

#pragma mark - RequestDelegate要求实现的方法
-(void)requestBegin{
    if (_flag) {
        [self.delegate publishCommentBegin];
        
    }else{
        [self.delegate getTopicModelBegin];
    }
}

-(void)requestFailed:(NSError *)error{
    if (_flag) {
        [self.delegate publishCommentFailed:error.description];
    }else{
        [self.delegate getTopicModelFailed:error.description];
    }
}

-(void)requestSuccessWithMsg:(NSString *)msg{
    if (_flag) {
        [self.delegate publishCommentSuccessWithMsg:msg];
    }else{
        [self.delegate getTopicModelSuccessWithMsg:msg];
    }
}

-(void)requestSuccess:(NSDictionary *)dic{
    if (_flag) {
        [self.delegate publishCommentSuccess];
    }else{
        NSDictionary *topicDic = [dic objectForKey:@"topic"];
        TopicModel *topic = [TopicModel objectWithKeyValues:topicDic];
        
        NSArray *commentArray = [dic objectForKey:@"commentList"];
        NSArray *commentList = [CommentModel objectArrayWithKeyValuesArray:commentArray];
     
        [self.delegate getTopicModelSuccessWithTopicModel:topic commentList:commentList];
    
    }
}
@end
