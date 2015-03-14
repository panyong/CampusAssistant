//
//  ViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-26.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"
#import "TimetableViewController.h"
#import "ImageConfig.h"
#import "FindViewController.h"
#import "AboutMeViewController.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    self.bl = [[LoginAndRegisterBusiness alloc]init];
    self.bl.delegate = self;
    

    [_accountImage setImage:[UIImage imageNamed:@"pic_super_account@2x.png"]];
    [_passwordImage setImage:[UIImage imageNamed:@"ic_register_password@2x.png"]];
    [_backgroundImage setImage:[UIImage imageNamed:@"ic_register_background@2x.png"]];
    [_iconImage setImage:[UIImage imageNamed:@"ic_register_login_top@2x.png"]];
    
    //自定义手势，当前VIEW接收到该手势后触发keyboardHide：方法，进行键盘的隐藏
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
	//将两个textField的delegate委托给本视图
    self.userNameField.delegate = self;
    self.pwdField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击注册按钮后的响应方法
- (IBAction)presentRegisterView:(id)sender {
    UIStoryboard *mainStoreboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RegisterViewController *registerVC = [mainStoreboard instantiateViewControllerWithIdentifier:@"registerViewController"];
    
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)login:(id)sender {
    NSString *userNameString = self.userNameField.text;
    NSString *pwdString = self.pwdField.text;
    
    if (userNameString == nil || userNameString.length == 0 || pwdString == nil || pwdString.length == 0) {
        [KVNProgress showErrorWithStatus:@"请正确填写用户名和密码~"];
        return;
        
    }

    [self.bl loginWithName:userNameString andPwd:pwdString];
    
    
}

#pragma 以下是LoginAndRegisterDelegate要实现的方法
-(void)loginBegin{
    [KVNProgress showProgress:1.0 status:@"登录ing..."];
    
//    [self.activity startAnimation];
}

-(void)loginSuccess{
    [KVNProgress dismiss];
    
    [KVNProgress showSuccessWithStatus:@"登录成功~"];
    
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
    
    NSLog(@"login");
}

-(void)loginSuccessWithMsg:(NSString *)msg{
    
    [KVNProgress dismiss];
    
    [KVNProgress showErrorWithStatus:@"咦~网络开小差了哦~"];
}

-(void)loginFailed:(NSError *)error{
     NSString *msg = [error localizedDescription];
    
    [KVNProgress dismiss];
    
    [KVNProgress showErrorWithStatus:msg];
   
   
}

//自定义手势触发后的响应方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.userNameField resignFirstResponder];
    [self.pwdField resignFirstResponder];
}

//当点击键盘上的“return”按钮时触发
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//放弃第一响应者身份
    return YES;
}



#pragma 下列代码可以用于当键盘遮挡控件时，ScrollView的滚动
//当试图即将加载时调用该方法
-(void)viewWillAppear:(BOOL)animated{
    //注册键盘出现通知，并在相应的selector里对该通知做出响应
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //注册键盘隐藏通知，并在相应的selector里对该通知做出响应
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [super viewWillAppear:animated];
}

//当试图即将消失时调用该方法
-(void)viewWillDisappear:(BOOL)animated{
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

-(void) keyboardDidShow:(NSNotification*) notify{
    
}

-(void) keyboardDidHide:(NSNotification*) notify{
    
}
@end
