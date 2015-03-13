//
//  MyCell.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-13.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel.h"

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacher;
@property (weak, nonatomic) IBOutlet UILabel *courseClassroom;
@property (weak, nonatomic) IBOutlet UILabel *courseSection;
@property (weak, nonatomic) IBOutlet UILabel *courseWeek;

@property (weak, nonatomic) IBOutlet UIImageView *teacherImage;
@property (weak, nonatomic) IBOutlet UIImageView *classroomImage;
@property (weak, nonatomic) IBOutlet UIImageView *sectionImage;
@property (weak, nonatomic) IBOutlet UIImageView *weekImage;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier courseInfo:(CourseModel*) course;
@end
