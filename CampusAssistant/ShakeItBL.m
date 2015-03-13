//
//  ShakeItBL.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-13.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ShakeItBL.h"
#import "NetConfig.h"
#import "MJExtension.h"
#import "CourseModel.h"

@implementation ShakeItBL

-(instancetype)init{
    self = [super init];
    if (self) {
        self.request = [[MyRequest alloc] init];
        self.request.delegate = self;
    }
    
    return self;
}


-(void)getCourseList{
    [self.request sendRequestWithPath:kCengkePath andParams:nil forMethod:kGet];
}

#pragma mark - RequestDelegate 要求实现的方法
-(void)requestBegin{
    [self.delegate getCoursesBegin];
}

-(void)requestFailed:(NSError *)error{
    [self.delegate getCoursesFailed:error.description];
    
}

-(void)requestSuccess:(NSDictionary *)dic{
    
    NSString *count = [dic objectForKey:@"count"];
    
    NSArray *courseArray = [dic objectForKeyedSubscript:@"courseList"];
    
    
    NSArray *courseList = [CourseModel objectArrayWithKeyValuesArray:courseArray];
    
    
    [self.delegate getCoursesSuccess:courseList andCount:count.intValue];
}

@end
