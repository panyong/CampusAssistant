//
//  ImportCourseDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImportCourseDelegate <NSObject>

@required
-(void) step1RequestSuccessWithPicData:(NSData*) pic;
-(void) step1RequestBegin;
-(void) step1RequestFailedWithMsg:(NSString*)msg;
@end
