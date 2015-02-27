//
//  LoginAndRegisterBusiness.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestDelegate.h"
#import "LoginAndRegisterDelegate.h"
#import "ObjectFileDelegate.h"
#import "MyRequest.h"

@interface LoginAndRegisterBusiness : NSObject<RequestDelegate,ObjectFileDelegate>
@property(weak,nonatomic) id<LoginAndRegisterDelegate> delegate;
@property(strong,nonatomic) MyRequest * request;
@property BOOL loginFlag;
//单例模式
+(LoginAndRegisterBusiness*) sharedManager;
-(void) loginWithName:(NSString*) userName andPwd:(NSString*) pwd;
-(void) registerWithName:(NSString*) userName andPwd:(NSString*) pwd andNickname:(NSString*) nickname;
@end
