//
//  CourseModel.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseModel : NSObject
@property(strong,nonatomic) NSString *courseId;
@property(strong,nonatomic) NSString *day;
@property(strong,nonatomic) NSString *startSchoolYear;
@property(strong,nonatomic) NSString *endSchoolYear;
@property(strong,nonatomic) NSString *locale;
@property(strong,nonatomic) NSString *maxCount;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *period;
@property(strong,nonatomic) NSString *sectionstart;
@property(strong,nonatomic) NSString *sectionend;
@property(strong,nonatomic) NSString *semester;
@property(strong,nonatomic) NSString *smartPeriod;
@property(strong,nonatomic) NSString *teacher;
@property(strong,nonatomic) NSString *supportAmount;
@property(strong,nonatomic) NSString *nonsupportAmount;
@property(strong,nonatomic) NSString *studentCount;
@end
