//
//  CommentBL.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyRequest.h"
#import "CommentDelegate.h"
#import "MJExtension/MJExtension.h"
#import "CommentModel.h"

@interface CommentBL : NSObject<RequestDelegate>
@property(weak,nonatomic) id<CommentDelegate> delegate;
@property(strong,nonatomic) MyRequest *request;


@property BOOL flag;

-(instancetype)init;

-(void) getTopicModelById:(int)topicId;
-(void) publishCommentWithTopicId:(int)topicId userId:(NSString*)userId content:(NSString*)content;
@end
