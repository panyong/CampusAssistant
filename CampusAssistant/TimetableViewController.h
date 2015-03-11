//
//  TimetableViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-27.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseBLDelegate.h"
#import "CourseBL.h"
#import "KVNProgress.h"
#import "DrawLabelAndButton.h"

@interface TimetableViewController : UIViewController<CourseBLDelegate>
@property(strong,nonatomic) CourseBL* courseBL;
@property(strong,nonatomic) KVNProgress *imgIndicator;
@property(strong,nonatomic) DrawLabelAndButton *drawer;
@property NSMutableDictionary *tag4CourseDictionary;


@property (strong, nonatomic) UIScrollView *scrollView;


-(void) loadCourseFromArray:(NSArray*)array;
@end
