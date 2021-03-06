//
//  RequestDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-28.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestDelegate <NSObject>
@required
-(void)requestBegin;
-(void)requestSuccess:(NSDictionary*) dic;
-(void)requestSuccessWithMsg:(NSString*) msg;
-(void)requestFailed:(NSError*) error;
@end
