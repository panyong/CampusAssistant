//
//  CourseBL.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectFileDelegate.h"
#import "ObjectFileManager.h"
#import "CourseBLDelegate.h"

@interface CourseBL : NSObject<ObjectFileDelegate>
@property(weak,nonatomic) id<CourseBLDelegate> delegate;
@property(strong,nonatomic) ObjectFileManager * objectFileManager;

//单例模式
+(CourseBL*) sharedManager;

-(void) readCourseArray;

@end
