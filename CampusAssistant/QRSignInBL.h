//
//  QRSignInBL.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QRSignInDelegate.h"
#import "MyRequest.h"
#import "RequestDelegate.h"

@interface QRSignInBL : NSObject<RequestDelegate>
@property(weak,nonatomic) id<QRSignInDelegate> delegate;
@property(strong,nonatomic) MyRequest *request;

-(instancetype)init;

-(void)signInWithCourseId:(NSString*)courseId userId:(NSString*)userId;
@end
