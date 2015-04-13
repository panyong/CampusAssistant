//
//  TopicModel.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicModel : NSObject
@property NSString* nickName;
@property NSString* content;
@property NSString* publishTime;
@property int topicId;
@property int commentCount;
@property int zanCount;
@end
