//
//  Semester.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Semester : NSObject
@property(strong,nonatomic) NSString *startSchoolYear;
@property(strong,nonatomic) NSString *endSchoolYear;
@property(strong,nonatomic) NSString *maxCount;
@property(strong,nonatomic) NSString *nowWeek;
@property(strong,nonatomic) NSString *semesterStr;
@end
