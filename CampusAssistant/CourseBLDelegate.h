//
//  Header.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseModel.h"

@protocol CourseBLDelegate <NSObject>
@optional
-(void)readCourseBegin;
-(void)readCourseSuccess:(NSArray*) array;
-(void)readCourseFailed:(NSString*) msg;

@optional
-(void)writeCourseBegin;
-(void)writeCourseSuccess;
-(void)wirteCourseFailed:(NSString*) msg;
@end