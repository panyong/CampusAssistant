//
//  BaseRequestUrl.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-27.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "BaseRequestUrl.h"

@implementation BaseRequestUrl


+(void) sendHttpRequestWithPath:(NSString* )path params:(NSDictionary*) body andHttpMethod:(NSString*) httpMethod
          withCompletionHandler:(void (^) (MKNetworkOperation* operation)) completionHandler
                andErrorHandler:(void (^) (MKNetworkOperation* operation)) errorHandler{
    
}


@end
