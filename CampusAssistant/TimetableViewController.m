//
//  TimetableViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-27.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "TimetableViewController.h"

@interface TimetableViewController ()

@end

@implementation TimetableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置背景图片
//    UIColor *backColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
//    [self.view setBackgroundColor:backColor];
    
    NSLog(@"TimetableViewController viewDidLoad!");
//    NSLog(@".:%@", NSStringFromCGRect(self.view.frame));
    
    //实例化业务类，并调用其加载课程表的方法
    self.courseBL = [CourseBL sharedManager];
    
    self.courseBL.delegate = self;
    
    [self.courseBL readCourseArray];
    
    
    // 初始化控件，周view， scrollview
    
    // Do any additional setup after loading the view.
}


-(void)viewDidLayoutSubviews
{
    // 设置frame
    [super viewDidLayoutSubviews];
    //初始化drawer
    self.drawer = [DrawLabelAndButton sharedManagerWithMainViewFrame:self.view.frame];
    
    
    //初始化scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 30, self.view.frame.size.width, self.view.frame.size.height)];
    [self.scrollView setBackgroundColor:[UIColor blueColor]];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, [self.drawer getContentSizeHeight])];
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];

    //调用draw方法，进行两类Label的绘制
    [self drawWeekAndSectionLabel];
    
    NSLog(@"..:%@", NSStringFromCGRect(self.view.frame));
}

#pragma 以下是加载课程表的方法
-(void)loadCourseFromArray:(NSArray *)array{
    
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
    
    //加载等待指示器
    [KVNProgress showProgress:2.0f status:@"Loading with progress..."];    //加载等待指示器
    
}

-(void)readCourseSuccess:(NSArray *)array{
    NSLog(@"VIEW:readCourseSuccess");
    
    [KVNProgress showSuccessWithStatus:@"Success"];
    
    [self loadCourseFromArray:array];
    
}
-(void)readCourseFailed:(NSString *)msg{
    NSLog(@"VIEW:readCourseFailed");
    [KVNProgress showSuccessWithStatus:msg];
    
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
