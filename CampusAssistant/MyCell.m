//
//  MyCell.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-13.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "MyCell.h"

#import "ImageConfig.h"

@implementation MyCell

- (void)awakeFromNib {
    // Initialization code
    
    if (self) {
        //初始化图标
        [self.teacherImage setImage:[UIImage imageNamed:kFind_shake_teacher_icon]];
        [self.classroomImage setImage:[UIImage imageNamed:kFind_shake_classroom_icon]];
        [self.sectionImage setImage:[UIImage imageNamed:kFind_shake_section_icon]];
        [self.weekImage setImage:[UIImage imageNamed:kFind_shake_week_icon]];
        
//        //初始化Label
//        NSString *sectionStr = [NSString stringWithFormat:@"%@ %@~%@节",[self getWeekInCN:course.day.intValue],course.sectionstart,course.sectionend];
//        NSString *weekStr = [NSString stringWithFormat:@"%@周",course.period];
//        
//        [self.courseName setText:course.name];
//        [self.courseTeacher setText:course.teacher];
//        [self.courseClassroom setText:course.locale];
//        [self.courseSection setText:sectionStr];
//        [self.courseName setText:weekStr];
        
        
    }

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier courseInfo:(CourseModel*) course{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
//    
//    if (self) {
//        //初始化图标
//        [self.teacherImage setImage:[UIImage imageNamed:kFind_shake_teacher_icon]];
//        [self.classroomImage setImage:[UIImage imageNamed:kFind_shake_classroom_icon]];
//        [self.sectionImage setImage:[UIImage imageNamed:kFind_shake_section_icon]];
//        [self.weekImage setImage:[UIImage imageNamed:kFind_shake_week_icon]];
//        
//        //初始化Label
//        NSString *sectionStr = [NSString stringWithFormat:@"%@ %@~%@节",[self getWeekInCN:course.day.intValue],course.sectionstart,course.sectionend];
//        NSString *weekStr = [NSString stringWithFormat:@"%@周",course.period];
//        
//        [self.courseName setText:course.name];
//        [self.courseTeacher setText:course.teacher];
//        [self.courseClassroom setText:course.locale];
//        [self.courseSection setText:sectionStr];
//        [self.courseName setText:weekStr];
//        
//        
//    }
    
    return self;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

@end
