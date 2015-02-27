//
//  MyResponseDto.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-28.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyResponseDto : NSObject

@property int httpCode;
@property NSString* httpMsg;
@property NSDictionary* httpDate;

@end
