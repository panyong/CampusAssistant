//
//  LoginAndRegisterBusiness.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "LoginAndRegisterBusiness.h"
#import "ObjectFileManager.h"

@implementation LoginAndRegisterBusiness
//static LoginAndRegisterBusiness* sharedManager;

-(LoginAndRegisterBusiness*) init{
//    static dispatch_once_t once;
//    dispatch_once(&once,^{
//        sharedManager = [[self alloc] init];
//        sharedManager.request = [[MyRequest alloc]init];
//        sharedManager.request.delegate = sharedManager;
//    });
//    return sharedManager;
    self = [super init];
    
    if (self) {
        self.request = [[MyRequest alloc] init];
        self.request.delegate = self;
    }
    return self;
}


//登录
-(void) loginWithName:(NSString*) userName andPwd:(NSString*) pwd{
    self.loginFlag = YES;
    
    [self.delegate loginBegin];//通知调用者登陆开始
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:userName forKey:@"userName"];
    [param setObject:pwd forKey:@"password"];
    
    
    [self.request sendRequestWithPath:kLoginPath andParams:param forMethod:kPost];
    
}

//注册
-(void) registerWithName:(NSString*) userName andPwd:(NSString*) pwd andNickname:(NSString*) nickname{
    self.loginFlag = NO;
    
    [self.delegate registerBegin];//通知调用者注册开始
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:userName forKey:@"userName"];
    [param setObject:pwd forKey:@"password"];
    [param setObject:nickname forKey:@"nickname"];
    
    
    [self.request sendRequestWithPath:kRegisterPath andParams:param forMethod:kPost];

}

#pragma 以下是RequestDelegate中要实现的方法
-(void)requestBegin{
    
}

-(void)requestFailed:(NSError *)error{
    if (self.loginFlag) {
        [self.delegate loginFailed:error];
    }else{
        [self.delegate registerFailed:error];
    }
}

-(void)requestSuccess:(NSDictionary *)dic{
    
    NSLog(@"requestSuccess，结果：data:%@",dic);//打印结果
    
    ObjectFileManager *manager = [[ObjectFileManager alloc]init];
    
    if (self.loginFlag) {
        
        if ([manager writeUserInfoWithDic:dic]) {
            [self.delegate loginSuccess];
        }else{
            [self.delegate loginSuccessWithMsg:@"写入属性列表失败"];
        }
        
    }else{
        
        if ([manager writeUserInfoWithDic:dic]) {
            [self.delegate registerSuccess];
        }else{
            [self.delegate registerSuccessWithMsg:@"写入属性列表失败"];
        }
        
    }
}


-(void)requestSuccessWithMsg:(NSString *)msg{
    if (self.loginFlag) {
        [self.delegate loginSuccessWithMsg:msg];
    }else{
        [self.delegate registerSuccessWithMsg:msg];
    }
}

@end
