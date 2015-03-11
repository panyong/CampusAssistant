//
//  CourseDetailViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-11.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "CourseDetailViewController.h"

@interface CourseDetailViewController ()

@end

@implementation CourseDetailViewController


-(CourseDetailViewController *)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundle course:(CourseModel *)course{
    self = [super initWithNibName:nibNameOrNil bundle:bundle];
    
    if (self) {
        self.course = course;
    }
    
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.courseNameFiled.text = self.course.name;
    self.courseTeacherField.text = self.course.teacher;
    self.courseLocationField.text = self.course.locale;
    self.coursePeriodField.text = self.course.period;
    
    NSString *week = [self getWeekInCN:self.course.day.intValue];
    
    
    self.courseSectionsField.text = [NSString stringWithFormat:@"%@ %@-%@节",week,self.self.course.sectionstart,self.course.sectionend];
    // Do any additional setup after loading the view from its nib.
}


-(NSString *) getWeekInCN:(int) week{
    
    NSString *weekCN = @"";
    
    switch (week) {
        case 1:
            weekCN = @"周一";
            break;
        case 2:
            weekCN = @"周二";
            break;
        case 3:
            weekCN = @"周三";
            break;
        case 4:
            weekCN = @"周四";
            break;
        case 5:
            weekCN = @"周五";
            break;
        case 6:
            weekCN = @"周六";
            break;
        case 7:
            weekCN = @"周日";
            break;
        default:
            break;
    }
    
    return weekCN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
