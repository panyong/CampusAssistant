//
//  TimetableViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-27.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "TimetableViewController.h"
#import "CourseDetailViewController.h"
#import "ImageConfig.h"

@interface TimetableViewController ()

@end

@implementation TimetableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone ;//设置view大小
    
    NSLog(@"TimetableViewController viewDidLoad!");
    
    self.title = @"课程表";
    
    //实例化业务类，并调用其加载课程表的方法
    self.courseBL = [[CourseBL alloc]init];
    
    self.courseBL.delegate = self;
    
    //设置背景图
    UIImageView *backgroungImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroungImageView.image = [UIImage imageNamed:kTimetable_background_image];
//    [backgroungImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.view addSubview:backgroungImageView];

    
    //初始化drawer
    self.drawer = [[DrawLabelAndButton alloc]initWithMainViewFrame:self.view.frame];
    
    
    //初始化scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 30, self.view.frame.size.width, self.view.frame.size.height)];
    [self.scrollView setBackgroundColor:[UIColor clearColor]];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, [self.drawer getContentSizeHeight])];
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    
    
    
    //调用draw方法，进行两类Label的绘制
    [self drawWeekAndSectionLabel];
    
    [self.courseBL readCourseArray];
    NSLog(@"..:%@", NSStringFromCGRect(self.view.frame));
    
}


-(void)viewDidLayoutSubviews
{
//    // 设置frame
//    [super viewDidLayoutSubviews];
//    
//    //初始化drawer
//    self.drawer = [[DrawLabelAndButton alloc]initWithMainViewFrame:self.view.frame];
//    
//    
//    //初始化scrollView
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 30, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.scrollView setBackgroundColor:[UIColor clearColor]];
//    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, [self.drawer getContentSizeHeight])];
//    self.scrollView.bounces = NO;
//    [self.view addSubview:self.scrollView];
//    
//    
//    
//    
//    //调用draw方法，进行两类Label的绘制
//    [self drawWeekAndSectionLabel];
//    
//    [self.courseBL readCourseArray];
//    NSLog(@"..:%@", NSStringFromCGRect(self.view.frame));
    
   
}

#pragma 以下是加载课程表的方法
-(void)loadCourseFromArray:(NSArray *)array{
    int tag = 0;
    self.tag4CourseDictionary = [[NSMutableDictionary alloc] init];
    
    for (CourseModel *course in array) {
        int week = course.day.intValue;
        int section = course.sectionstart.intValue;
        int sectionCount = (course.sectionend.intValue - course.sectionstart.intValue) + 1;
        
        CGRect btnRect = [self.drawer getBtnFrameforWeek:week andSection:section andSectionCount:sectionCount];
        
        UILabel *courseLabel = [[UILabel alloc] initWithFrame:btnRect];
        //设置text
        NSString *btnContent = [NSString stringWithFormat:@"%@@%@",course.name,course.locale];
        [courseLabel setText:btnContent];
        [courseLabel setFont:[UIFont systemFontOfSize:11.0]];
        [courseLabel setTextAlignment:NSTextAlignmentCenter];//设置对齐方式
        [courseLabel setNumberOfLines:0];//设置换行
        [courseLabel setAdjustsFontSizeToFitWidth:YES];//设置字体自动适应
        [courseLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
        [courseLabel setTextColor:[UIColor whiteColor]];
        //设置随机的背景颜色
        CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
        UIColor *labelColor =  [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.8];
        courseLabel.backgroundColor = labelColor;//[UIColor redColor];
        
        
        //设置圆角
        [courseLabel.layer setMasksToBounds:YES];
        [courseLabel.layer setCornerRadius:5.0];
        [courseLabel.layer setBorderWidth:0.3];
        
        //增加Tag
        tag++;
        [courseLabel setTag:tag];
        [self.tag4CourseDictionary setObject:course forKey:[NSString stringWithFormat:@"%i",tag]];
        
        //添加点击事件
        UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(courseLabelEvent:)];
        courseLabel.userInteractionEnabled = YES;//设置接收用户操作
        [courseLabel addGestureRecognizer:tapGestureTel];
        
        [self.scrollView addSubview:courseLabel];
        

    }
}

#pragma mark - 手势点击事件处理方法
-(void) courseLabelEvent:(UITapGestureRecognizer *)sender{
    if (sender.numberOfTapsRequired) {
        UILabel *tapLabel =  (UILabel *)sender.view;
        NSInteger labelTag = tapLabel.tag;
        CourseModel *course = [self.tag4CourseDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)labelTag]];
        
        CourseDetailViewController *courseDetailVC = [[CourseDetailViewController alloc] initWithNibName:@"CourseDetailViewController" bundle:nil course:course];
        
        [self.navigationController pushViewController:courseDetailVC animated:YES];
        
//        NSLog(@"course:%@",course.name);
        
//        NSLog(@"Label内容:%@",tapLabel.text);
        
        NSLog(@"跳转到课程详情页");
    }
}

#pragma 以下是绘制Label的方法
-(void) drawWeekAndSectionLabel{
    NSMutableArray *sectionArray = [self.drawer getSectionLabelsFrame];
    
    NSMutableArray *weekArray = [self.drawer getWeekLabelsFrame];
    
    for (UILabel *weekLabel in weekArray) {
        [self.view addSubview:weekLabel];
    }
    
    for (UILabel *sectionLabel in sectionArray) {
        [self.scrollView addSubview:sectionLabel];
    }
}




#pragma  以下是CourseBLDelegate中要求实现的方法
-(void)readCourseBegin{
    NSLog(@"VIEW:readCourseBegin");
    

//    [KVNProgress showProgress:2.0f status:@"Loading with progress..."];    //加载等待指示器
    
}

-(void)readCourseSuccess:(NSArray *)array{
    NSLog(@"VIEW:readCourseSuccess");
    
//    [KVNProgress showSuccessWithStatus:@"Success"];
    
    NSLog(@"courseList:%@",array);
    
    [self loadCourseFromArray:array];
    
}
-(void)readCourseFailed:(NSString *)msg{
    NSLog(@"VIEW:readCourseFailed");
    [KVNProgress showErrorWithStatus:msg];
    
//    [self performSelector:@selector(delayView) withObject:nil afterDelay:1.5];
}


- (void)delayView
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
