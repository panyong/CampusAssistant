//
//  ShakeItViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ShakeItViewController.h"
#import "KVNProgress.h"
@interface ShakeItViewController ()

@end

@implementation ShakeItViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.shakeItBl = [[ShakeItBL alloc] init];
        self.shakeItBl.delegate = self;
    }
    
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - 摇一摇的方法
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"摇动开始");
    
    [KVNProgress showProgress:1.0 status:@"正在查询课程..."];
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"摇动结束");
    
    [self.shakeItBl getCourseList];
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"摇动取消");
 
}


#pragma mark - ShakeItDelegate要求实现的方法
-(void)getCoursesBegin{
    
}

-(void)getCoursesFailed:(NSString *)msg{
    [KVNProgress showErrorWithStatus:msg];
}

-(void)getCoursesSuccess:(NSMutableArray *)courseList andCount:(int)count{
    NSString *wowStr = [NSString stringWithFormat:@"哇，摇到了%i门可以蹭的课程呢",count];
    self.tipLabel.text = wowStr;
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
