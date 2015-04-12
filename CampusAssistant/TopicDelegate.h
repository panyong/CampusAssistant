//
//  TopicDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TopicDelegate <NSObject>


@optional
-(void)getTopicListBegin;
-(void)getTopicListFailed:(NSString*)msg;
-(void)getTopicListSuccess:(NSArray*)topicList andCount:(int) count;
-(void)getTopicListSuccessWithMsg:(NSString*)msg;

@end