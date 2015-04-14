//
//  TopicCellDelegate.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TopicCell;

@protocol TopicCellDelegate <NSObject>


@optional
-(void)zanSuccessInCell:(TopicCell*) cell;
-(void)commentSuccessInCell:(TopicCell*) cell;
@end