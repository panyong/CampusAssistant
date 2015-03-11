//
//  ViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-26.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    
    self.bl = [[LoginAndRegisterBusiness alloc]init];
    self.bl.delegate = self;
    
    
//    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.loginBtn.layer.cornerRadius = 50;
//    self.loginBtn.layer.masksToBounds = YES;
    
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
        UIAlertView * nameOrPwdNull = [[UIAlertView alloc] initWithTitle:@"登录" message:@"请输入用户名和密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [nameOrPwdNull show];
        return;
        
    }

    [self.bl loginWithName:userNameString andPwd:pwdString];
    
    
}

#pragma 以下是LoginAndRegisterDelegate要实现的方法
-(void)loginBegin{
    self.activity = [[YYAnimationIndicator alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width/4, self.view.frame.size.height/4)];//指定进度轮的大小
    
    [self.activity setCenter:CGPointMake(160, 140)];//指定进度轮中心点
    
    [self.activity setLoadText:@"拼命加载ing"];
    
    [self.view addSubview:self.activity];
    
//    [self.activity startAnimation];
}

-(void)loginSuccess{
    
    [self.activity stopAnimationWithLoadText:@"登陆成功~" withType:YES];
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController* mainTabBarController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    [self presentViewController:mainTabBarController animated:YES completion:nil];
    
    NSLog(@"login");
}

-(void)loginSuccessWithMsg:(NSString *)msg{
    
    [self.activity stopAnimationWithLoadText:@"咦~网络开小差了哦~" withType:YES];
    
    UIAlertView * nameOrPwdNull = [[UIAlertView alloc] initWithTitle:@"登录失败" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [nameOrPwdNull show];
}

-(void)loginFailed:(NSError *)error{
    [self.activity stopAnimationWithLoadText:[error localizedDescription] withType:YES];
    
    NSString *msg = [error localizedDescription];
    UIAlertView * nameOrPwdNull = [[UIAlertView alloc] initWithTitle:@"登录" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [nameOrPwdNull show];
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
