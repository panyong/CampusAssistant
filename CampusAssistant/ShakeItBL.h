//
//  ShakeItBL.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//









#import <Foundation/Foundation.h>
#import "ShakeItDelegate.h"
#import "MyRequest.h"
#import "RequestDelegate.h"

@interface ShakeItBL : NSObject<RequestDelegate>
@property(weak,nonatomic) id<ShakeItDelegate> delegate;
@property(strong,nonatomic) MyRequest *request;

-(instancetype)init;

-(void) getCourseList;
@end
