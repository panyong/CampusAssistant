//
//  ImportCourseBL.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ImportCourseBL.h"


@implementation ImportCourseBL


static ImportCourseBL* sharedManager;

+(ImportCourseBL*) sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedManager = [[self alloc] init];
        sharedManager.myRequest = [MyRequest sharedManager];
        sharedManager.myRequest.delegate = sharedManager;
    });
    return sharedManager;
}

-(void)beginStep1RequestWithStuNo:(NSString *)stuNo andStuPwd:(NSString *)stuPwd{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setObject:stuPwd forKey:@"stuNum"];
    [param setObject:stuPwd forKey:@"stuPassword"];
    
    [self.myRequest sendRequestWithPath:kGetVerifyPath andParams:param forMethod:kGet];
}

#pragma 以下是requestDelegate中要求实现的方法
-(void)requestBegin{
    [self.delegate step1RequestBegin];
}

-(void)requestSuccess:(NSDictionary *)dic{
    NSData *picStr = [dic objectForKey:@"pic"];
    
    [self.delegate step1RequestSuccessWithPicData:picStr];
}

-(void)requestSuccessWithMsg:(NSString *)msg{
    NSLog(@"do nothing");
    
}

-(void)requestFailed:(NSError *)error{
    [self.delegate step1RequestFailedWithMsg:error.description];
}
@end
