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

static CourseBL* sharedManager;

+(CourseBL*) sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedManager = [[self alloc] init];
        sharedManager.objectFileManager = [ObjectFileManager sharedManager];
        sharedManager.objectFileManager.delegate = sharedManager;
    });
    return sharedManager;
}


//VIEW调用，读取Course的数组
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
