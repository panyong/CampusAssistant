//
//  DrawLabelAndButton.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-30.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawLabelAndButton : NSObject
//@property CGRect* frame;
@property float weekWidth;
@property float weekHeight;
@property float sectionWidth;
@property float sectionHeight;
@property float contentSizeHeight;
@property CGPoint point;
@property(strong,nonatomic) NSArray *weeksArray;
@property(strong,nonatomic) NSArray *sectionsArray;


-(DrawLabelAndButton*) initWithMainViewFrame:(CGRect) mainViewFrame;
//-(float) getWidth;
//-(float) getHeight;
-(CGRect) getBtnFrameforWeek:(int)week andSection:(int)section andSectionCount:(int) count;
-(NSMutableArray*) getWeekLabelsFrame;
-(NSMutableArray*) getSectionLabelsFrame;
-(float) getContentSizeHeight;
@end
