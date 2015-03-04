//
//  NetConfig.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-28.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//



#pragma http method常量
#define kPost  @"POST"
#define kGet @"GET"
#define kUpdate @"UPDATE"



#pragma host name 常量
#define kHostName @"10.101.145.252:8666/SpringMVCTest"
//#define kHostName @"192.168.1.109:8080/SpringMVCTest"

#pragma 常用的path常量
#define kLoginPath @"/user/login/v1"//登录
#define kGetVerifyPath @"/timetable/getVerification/v1"//获取课程表第一步
#define kCheckVerifyPath @"/timetable/checkVerification/v1";//获取课程表第二步
#define kRegisterPath @"/user/register/v1"//注册