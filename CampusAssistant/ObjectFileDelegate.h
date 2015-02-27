//
//  ObjectFileDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectFileDelegate <NSObject>
@optional
-(void)writeBegin;
-(void)writeSuccess;
-(void)writeFailedWithMsg:(NSString*) msg;

@optional
-(void)readBegin;
-(void)readSuccess:(NSDictionary*) dic;
-(void)readFailedWithMsg:(NSString*) msg;
@end
