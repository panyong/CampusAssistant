//
//  CourseBL.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "CourseBL.h"
#import "CourseConfig.h"
#import "MJExtension.h"

@implementation CourseBL

//static CourseBL* sharedManager;

-(CourseBL*) init{
//    static dispatch_once_t once;
//    dispatch_once(&once,^{
//        sharedManager = [[self alloc] init];
//        sharedManager.objectFileManager = [[ObjectFileManager alloc]init];
//        sharedManager.objectFileManager.delegate = sharedManager;
//    });
//    return sharedManager;
    
    self = [super init];
    
    if (self) {
        self.objectFileManager = [[ObjectFileManager alloc] init];
        self.objectFileManager.delegate = self;
    }
    return  self;
}


#pragma VIEW调用，读取Course的数组
-(void)readCourseArray{
    
    
    
    [self.objectFileManager readDictionaryFromFile:kCourseFileName];
}


#pragma 以下是ObjectFileDelegate中要实现的方法
-(void)readBegin{
    NSLog(@"BL:readBegin");
    
    [self.delegate readCourseBegin];
}

//读取成功时回调，将courseList作为数组返回给调用者
-(void)readSuccess:(NSDictionary *)dic{
    NSLog(@"BL:readSuccess");
    
    NSArray *arrayDic = [dic objectForKey:@"courseList"];
    
    NSArray *courseList = [CourseModel objectArrayWithKeyValuesArray:arrayDic];
    
    [self.delegate readCourseSuccess:courseList];
}

-(void)readFailedWithMsg:(NSString *)msg{
    NSLog(@"BL:readFailedWithMsg");
    
    
    [self.delegate readCourseFailed:msg];
}
@end
