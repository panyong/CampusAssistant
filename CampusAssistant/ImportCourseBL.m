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

-(void)beginStep1RequestWithStuNo:(NSString *)stuNo andStuPwd:(NSString *)stuPwd{
    self.flag = YES;
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setObject:stuPwd forKey:@"stuNum"];
    [param setObject:stuPwd forKey:@"stuPassword"];
    
    [self.myRequest sendRequestWithPath:kGetVerifyPath andParams:param forMethod:kGet];
}


-(void) beginStep2RequestWithVerifyCode:(NSString*) verifyCode{
    self.flag = NO;
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setObject:verifyCode forKey:@"verifyCode"];
    
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
        NSString *picStr = [dic objectForKey:@"pic"];
        
        NSData *picData = [[NSData alloc] initWithBase64EncodedString:picStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        [self.delegate step1RequestSuccessWithPicData:picData];
    }else{

        [self.delegate step2RequestSuccess];
        [self.objectManager writeDictionary:dic IntoFile:kCourseFileName];
        
    }
}

-(void)requestSuccessWithMsg:(NSString *)msg{
    NSLog(@"do nothing");
    
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
