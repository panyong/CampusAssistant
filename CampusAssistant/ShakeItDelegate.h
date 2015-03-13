//
//  ShakeItDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShakeItDelegate <NSObject>


@required
-(void)getCoursesBegin;
-(void)getCoursesFailed:(NSString*)msg;
-(void)getCoursesSuccess:(NSArray*)courseList andCount:(int) count;

@end