//
//  ZanBL.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZanDelegate.h"
#import "MyRequest.h"

@interface ZanBL : NSObject<RequestDelegate>
@property(weak,nonatomic) id<ZanDelegate> delegate;
@property(strong,nonatomic) MyRequest *request;


-(void)zanWithUserId:(NSString*)userId andTopicId:(int)topicId;
-(instancetype)init;
@end
