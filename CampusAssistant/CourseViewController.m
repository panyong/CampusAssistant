//
//  CourseViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-13.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "CourseViewController.h"
#import "MyCell.h"

@interface CourseViewController ()

@end

@implementation CourseViewController

-(instancetype)init:(NSArray *)courseList{
    self = [super init];
    
    if (self) {
        self.courseList = courseList;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"课程列表";
    
    
    CGFloat x = self.view.frame.origin.x;
    CGFloat y = self.view.frame.origin.y;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    _courseTable  = [[UITableView alloc]initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
    
    [self.view addSubview:_courseTable];
    
    self.courseTable.delegate = self;
    
    self.courseTable.dataSource = self;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - uitabelview方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _courseList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"courseCell";
    
    MyCell *cell = (MyCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    CourseModel *course = [_courseList objectAtIndex:[indexPath row]];
    
    //初始化Label
    NSString *sectionStr = [NSString stringWithFormat:@"%@ %@~%@节",[self getWeekInCN:course.day.intValue],course.sectionstart,course.sectionend];
    NSString *weekStr = [NSString stringWithFormat:@"%@周",course.period];
    
    [cell.courseName setText:course.name];
    [cell.courseTeacher setText:course.teacher];
    [cell.courseClassroom setText:course.locale];
    [cell.courseSection setText:sectionStr];
    [cell.courseWeek setText:weekStr];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




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
