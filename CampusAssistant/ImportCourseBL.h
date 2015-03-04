//
//  ImportCourseBL.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyRequest.h"
#import "RequestDelegate.h"
#import "ImportCourseDelegate.h"

@interface ImportCourseBL : NSObject<RequestDelegate>
@property(weak,nonatomic) id<ImportCourseDelegate> delegate;
@property(strong,nonatomic) MyRequest *myRequest;

+(ImportCourseBL*) sharedManager;

-(void) beginStep1RequestWithStuNo:(NSString*) stuNo andStuPwd:(NSString*) stuPwd;
@end
