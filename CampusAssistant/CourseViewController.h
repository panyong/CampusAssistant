//
//  CourseViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-13.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView *courseTable;

@property NSArray *courseList;

-(instancetype)init:(NSArray*)courseList;

@end
