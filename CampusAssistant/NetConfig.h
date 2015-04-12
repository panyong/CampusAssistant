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
//#define kHostName @"192.168.1.104:8080/SpringMVCTest"
#define kHostName @"182.254.137.198:8080/ShiepApp"

#pragma 常用的path常量
#define kLoginPath @"/user/login/v1"//登录
#define kGetVerifyPath @"/timetable/getVerification/v1"//获取课程表第一步
#define kCheckVerifyPath @"/timetable/checkVerification/v1"//获取课程表第二步
#define kRegisterPath @"/user/register/v1"//注册
#define kQRSignInPath @"/find/sign_in/v1"//二维码签到
#define kCengkePath @"/find_cengke/v1"//摇一摇蹭课
#define kFindTopicListPath @"find/topic/get_list/v1"//获取话题列表
#define kFindCommentListPath @"/find/topic/get_comment_list/v1"//获取评论列表
#define kFindTopicPublishPath @"/find/topic/publish/v1"//发表话题
#define kFindCommentPublishPath @"/find/topic/comment/publish/v1"//发表评论
#define kFindZanPublishPath @"/find/topic/zan/publish/v1"//赞
