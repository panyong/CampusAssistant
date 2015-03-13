//
//  ObjectFileManager.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-29.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "ObjectFileDelegate.h"
#import "Semester.h"

@interface ObjectFileManager : NSObject
@property(weak,nonatomic) id<ObjectFileDelegate> delegate;

-(ObjectFileManager*) init;
-(BOOL) checkLoginInfo;
-(BOOL) writeUserInfo:(UserInfoModel*) user;
-(BOOL) writeUserInfoWithDic:(NSDictionary*) dic;

-(BOOL) writeDictionary:(NSDictionary*) dic IntoFile:(NSString*) fileName;
-(BOOL) readDictionaryFromFile:(NSString*) fileName;

-(void) removeAllFile;

-(NSString*)getNickname;
-(Semester*)getSemesterInfo;
-(void)setSemester:(Semester*)semester;
@end
