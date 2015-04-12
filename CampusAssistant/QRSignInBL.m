//
//  QRSignInBL.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "QRSignInBL.h"
#import "NetConfig.h"

@implementation QRSignInBL

-(instancetype)init{
    self = [super init];
    if (self) {
        self.request = [[MyRequest alloc] init];
        self.request.delegate = self;
    }
    
    return self;
}



-(void)signInWithCourseId:(NSString *)courseId userId:(NSString *)userId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:courseId forKey:@"courseId"];
    [params setObject:userId forKey:@"userId"];
    
    [self.request sendRequestWithPath:kQRSignInPath andParams:params forMethod:kPost];
}

#pragma mark - 以下为RequestDelegate要求实现的方法
-(void)requestBegin{
    [self.delegate signInBegin];
}

-(void)requestFailed:(NSError *)error{
    [self.delegate signInFailed:error.description];
}

-(void)requestSuccess:(NSDictionary *)dic{
    [self.delegate signInSuccess:@"签到成功!"];
}
-(void)requestSuccessWithMsg:(NSString *)msg{
    [self.delegate signInSuccessWithMsg:msg];
}
@end
