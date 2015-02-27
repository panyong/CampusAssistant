//
//  MyRequest.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-28.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestDelegate.h"
#import "MKNetworkKit.h"
#import "NetConfig.h"

@interface MyRequest : NSObject
@property(weak,nonatomic) id<RequestDelegate> delegate;

//单例模式
+(MyRequest*) sharedManager;

//发送请求的方法
-(void)sendRequestWithPath:(NSString*) path andParams:(NSMutableDictionary*) params forMethod:(NSString*) httpMethod;
@end
