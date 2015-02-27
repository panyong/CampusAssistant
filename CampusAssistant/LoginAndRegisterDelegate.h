//
//  LoginAndRegisterDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@protocol LoginAndRegisterDelegate <NSObject>
@optional
-(void)loginBegin;
-(void)loginSuccess;
-(void)loginSuccessWithMsg:(NSString*) msg;
-(void)loginFailed:(NSError*) error;
@optional
-(void)registerBegin;
-(void)registerSuccess;
-(void)registerSuccessWithMsg:(NSString*) msg;
-(void)registerFailed:(NSError*) error;
@end
