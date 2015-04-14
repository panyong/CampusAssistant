//
//  ZanDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZanDelegate <NSObject>


@optional
-(void)publishZanBegin;
-(void)publishZanFailed:(NSString*)msg;
-(void)publishZanSuccess;
-(void)publishZanSuccessWithMsg:(NSString*)msg;

@end