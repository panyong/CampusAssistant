//
//  QRSignInDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol QRSignInDelegate <NSObject>

@required
-(void)signInBegin;
-(void)signInSuccess:(NSString*) msg;
-(void)signInFailed:(NSString*)msg;
@end