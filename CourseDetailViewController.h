//
//  CourseDetailViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-11.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel.h"

@interface CourseDetailViewController : UIViewController

@property CourseModel *course;

@property (weak, nonatomic) IBOutlet UILabel *courseNameFiled;
@property (weak, nonatomic) IBOutlet UILabel *courseLocationField;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacherField;
@property (weak, nonatomic) IBOutlet UILabel *courseSectionsField;
@property (weak, nonatomic) IBOutlet UILabel *coursePeriodField;


-(CourseDetailViewController *)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*) bundle course:(CourseModel*)course;

@end
