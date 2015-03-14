//
//  SetNowWeekDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SetNowWeekDelegate <NSObject>

@required
-(void)setnowWeekCompile:(NSString*)nowWeek;

@end
