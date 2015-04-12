//
//  ImportCourseBL.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ImportCourseBL.h"
#import "MJExtension/MJExtension.h"
#import "CourseModel.h"
#import "CourseConfig.h"

@implementation ImportCourseBL


//static ImportCourseBL* sharedManager;

-(ImportCourseBL*) init{
//    static dispatch_once_t once;
//    dispatch_once(&once,^{
//        sharedManager = [[self alloc] init];
//        sharedManager.myRequest = [MyRequest sharedManager];
//        sharedManager.myRequest.delegate = sharedManager;
//    });
//    return sharedManager;
    
    self = [super init];
    
    if (self) {
        self.myRequest = [[MyRequest alloc]init];
        self.myRequest.delegate = self;
        
        self.objectManager = [[ObjectFileManager alloc] init];
        self.objectManager.delegate = self;
    }
    
    return  self;
}

-(void)beginStep1RequestWithStuNo:(NSString *)stuNo andStuPwd:(NSString *)stuPwd andClassNo:(NSString *)classNo andUserId:(NSString*)userId{
    self.flag = YES;
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setObject:stuNo forKey:@"stuNum"];
    [param setObject:stuPwd forKey:@"stuPassword"];
    [param setObject:classNo forKey:@"stuClassNo"];
    [param setObject:userId forKey:@"userId"];
    
    [self.myRequest sendRequestWithPath:kGetVerifyPath andParams:param forMethod:kGet];
}


-(void) beginStep2RequestWithVerifyCode:(NSString*) verifyCode andImgName:(NSString *)imgName andTimetableId:(NSString*)timetableId{
    self.flag = NO;
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setObject:verifyCode forKey:@"verifyCode"];
    [param setObject:imgName forKey:@"imgName"];
    [param setObject:timetableId forKey:@"timetableId"];
    
    [self.myRequest sendRequestWithPath:kCheckVerifyPath andParams:param forMethod:kGet];
}

#pragma 以下是requestDelegate中要求实现的方法
-(void)requestBegin{
    if (self.flag) {
        [self.delegate step1RequestBegin];
    }else{
        [self.delegate step2RequestBegin];
    }
}

-(void)requestSuccess:(NSDictionary *)dic{
    if (self.flag) {
//        NSDictionary *picDic = [dic objectForKey:@"pic"];
        
        PictureModel *pic = [PictureModel objectWithKeyValues:dic];
        
        [self.delegate step1RequestSuccessWithPicData:pic];
    }else{

        [self.delegate step2RequestSuccess];
        
//        NSDictionary *courseDic = [dic objectForKey:@"courseList"];
        
        [self.objectManager writeDictionary:dic IntoFile:kCourseFileName];
        
        NSDictionary *semesterDic = [dic objectForKey:@"semester"];
        
        Semester *semester = [Semester objectWithKeyValues:semesterDic];
        [self.objectManager setSemester:semester];
        
    }
}

-(void)requestSuccessWithMsg:(NSString *)msg{
    if (self.flag) {
        [self.delegate step1RequestSuccessWithMsg:msg];
    }else{
        [self.delegate step2RequestSuccessWithMsg:msg];
    }
    
}

-(void)requestFailed:(NSError *)error{
    if (self.flag) {
        [self.delegate step1RequestFailedWithMsg:error.description];
    }else{
        [self.delegate step2RequestFailedWithMsg:error.description];
    }
}

#pragma 以下是objectManagerDelegate中要求实现的方法
-(void)writeBegin{
    [self.delegate writeBegin];
}

-(void)writeFailedWithMsg:(NSString *)msg{
    [self.delegate writeFailedWithMsg:msg];
}

-(void)writeSuccess{
    [self.delegate writeSuccess];
}
@end
