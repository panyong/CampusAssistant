//
//  CommentDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicModel.h"

@protocol CommentDelegate <NSObject>



@optional
-(void)publishCommentBegin;
-(void)publishCommentFailed:(NSString*)msg;
-(void)publishCommentSuccess;
-(void)publishCommentSuccessWithMsg:(NSString*)msg;
@optional
-(void)getTopicModelBegin;
-(void)getTopicModelFailed:(NSString*)msg;
-(void)getTopicModelSuccessWithTopicModel:(TopicModel*)topic commentList:(NSArray*)commentList;
-(void)getTopicModelSuccessWithMsg:(NSString*)msg;


@end