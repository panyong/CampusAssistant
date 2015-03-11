//
//  ImportCourseStep2VC.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-9.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ImportCourseStep2VC.h"
#import "KVNProgress.h"
#import "TimetableViewController.h"
#import "ImageConfig.h"
#import "FindViewController.h"
#import "AboutMeViewController.h"

@interface ImportCourseStep2VC ()

@end

@implementation ImportCourseStep2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageWithData:self.picData];
    self.verifyCodeImage.image = image;
    
    self.bl = [[ImportCourseBL alloc]init];
    self.bl.delegate = self;
    
    self.verifyCodeField.delegate = self;

    
    //自定义手势，当前VIEW接收到该手势后触发keyboardHide：方法，进行键盘的隐藏
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
        // Do any additional setup after loading the view from its nib.
}

-(ImportCourseStep2VC *)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundle picData:(NSData *)picData{
    self = [super initWithNibName:nibNameOrNil bundle:bundle];
    if (self) {
        self.picData = picData;
    }
    
    return self;
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
#pragma 按钮事件
- (IBAction)nextStep:(id)sender {
    NSString *verifyCode = self.verifyCodeField.text;
    
    if (verifyCode.length == 0) {
        [KVNProgress showErrorWithStatus:@"验证码不能为空"];
        return;
    }
    
    [self.bl beginStep2RequestWithVerifyCode:verifyCode];
}

- (IBAction)cancleStep:(id)sender {
    
    [self.view removeFromSuperview] ;
    [self removeFromParentViewController] ;
}

#pragma 以下为ImportCourseDelegate中要求实现的方法
-(void)step2RequestBegin{
    
}

-(void)step2RequestSuccess{
    //TODO
}

-(void)step2RequestFailedWithMsg:(NSString *)msg{
    [KVNProgress showErrorWithStatus:@"网络在开小差，请重试~"];
}

-(void)writeBegin{
    
}

-(void)writeFailedWithMsg:(NSString *)msg{
    [KVNProgress showErrorWithStatus:@"课程表写入出错，请重试~"];
}

-(void)writeSuccess{
    //TODO remove该view并跳转到课程表界面
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
//    //实例化主故事版
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    UITabBarController *timetableVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
//    
//    [UIApplication sharedApplication].keyWindow.rootViewController = timetableVC;
    
#pragma  mark -- 用代码初始化tabbarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    //课程表
    TimetableViewController *timetabelVC = [[TimetableViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *timetabelNC = [[UINavigationController alloc] initWithRootViewController:timetabelVC];
    timetabelVC.navigationItem.title = @"课程表";
    timetabelNC.tabBarItem.title = @"课程表";
    timetabelNC.tabBarItem.image = [UIImage imageNamed:kTabbar_course_detail_icon];
    [tabBarController addChildViewController:timetabelNC];
    //发现
    FindViewController *findVC = [[FindViewController alloc] init];
    UINavigationController *findNC = [[UINavigationController alloc] initWithRootViewController:findVC];
    findVC.navigationItem.title = @"发现";
    findNC.tabBarItem.title = @"发现";
    findNC.tabBarItem.image = [UIImage imageNamed:kTabbar_find_icon];
    [tabBarController addChildViewController:findNC];
    //关于我
    AboutMeViewController *aboutMeVC = [[AboutMeViewController alloc] init];
    UINavigationController *aboutMeNC = [[UINavigationController alloc] initWithRootViewController:aboutMeVC];
    aboutMeVC.navigationItem.title = @"个人中心";
    aboutMeNC.tabBarItem.title = @"个人中心";
    aboutMeNC.tabBarItem.image = [UIImage imageNamed:kTabbar_setting_icon];
    [tabBarController addChildViewController:aboutMeNC];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
    
    NSLog(@"跳转到课程表界面");
}

#pragma 图片处理事件
-(void)initImageData:(NSData *)pic{
    UIImage *codeImage = [UIImage imageWithData:pic];
    [self.verifyCodeImage setImage:codeImage];
}

#pragma 键盘隐藏
//自定义手势触发后的响应方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.verifyCodeField resignFirstResponder];
    
}

-(void)keyboardHide{
    [self.verifyCodeField resignFirstResponder];
   
}

//当点击键盘上的“return”按钮时触发
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//放弃第一响应者身份
    return YES;
}

@end
