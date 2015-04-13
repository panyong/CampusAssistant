//
//  TopicBL.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyRequest.h"
#import "RequestDelegate.h"
#import "TopicDelegate.h"
#import "TopicModel.h"

@interface TopicBL : NSObject<RequestDelegate>
@property(weak,nonatomic) id<TopicDelegate> delegate;

@property BOOL flag;
@property(strong,nonatomic) MyRequest *request;

-(instancetype)init;

-(void) getTopicList;
-(void) publishTopicWithUserId:(NSString*)userId andContent:(NSString*)content;
@end
