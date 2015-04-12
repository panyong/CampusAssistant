//
//  ImportCourseDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureModel.h"

@protocol ImportCourseDelegate <NSObject>

@optional
-(void) step1RequestSuccessWithPicData:(PictureModel*) pic;
-(void) step1RequestBegin;
-(void) step1RequestFailedWithMsg:(NSString*)msg;
-(void) step1RequestSuccessWithMsg:(NSString*) msg;

@optional
-(void) step2RequestSuccess;
-(void) step2RequestBegin;
-(void) step2RequestFailedWithMsg:(NSString*)msg;
-(void) step2RequestSuccessWithMsg:(NSString*) msg;

@optional
-(void) writeSuccess;
-(void) writeFailedWithMsg:(NSString*) msg;
-(void) writeBegin;
@end
