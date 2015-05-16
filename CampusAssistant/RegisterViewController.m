//
//  RegisterViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-2-3.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "RegisterViewController.h"
#import "InputHelper.h"
#import "ImportCourseStep1VC.h"

@implementation UIView (FindFirstResponder)

-(UIView*) findFirstResponder {
    
    if (self.isFirstResponder) return self;
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) return firstResponder;
    }
    return nil;
    
}

@end

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bl = [[LoginAndRegisterBusiness alloc]init];
    self.bl.delegate = self;
    
    
    [_backgroundImage setImage:[UIImage imageNamed:@"ic_register_background@2x.png"]];
    [_iconImage setImage:[UIImage imageNamed:@"ic_register_login_top@2x.png"]];
    
    //自定义手势，当前VIEW接收到该手势后触发keyboardHide：方法，进行键盘的隐藏
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    

    
    self.title = @"注册";
    // Do any additional setup after loading the view.
}

- (IBAction)register:(id)sender {
    NSLog(@"点击注册");
    
    if([self validateText]){
        [self.bl registerWithName:self.userName.text andPwd:self.userPwd.text andNickname:self.userNickname.text];
    }else{
        NSLog(@"验证失败");
    }
    
    
}

-(BOOL) validateText{
    NSString *userName = self.userName.text;
    NSString *userPwd = self.userPwd.text;
    NSString *userPwd2 = self.userPwd2.text;
    NSString *userNickname = self.userNickname.text;
    
    if (userName.length == 0) {
        [KVNProgress showErrorWithStatus:@"用户名不能为空"];
        return NO;
    }
    
    if (userPwd.length == 0 || userPwd2.length == 0 ) {
        [KVNProgress showErrorWithStatus:@"密码不能为空"];

        return NO;
    }
    
    if (![userPwd2 isEqualToString:userPwd]) {
        [KVNProgress showErrorWithStatus:@"两次密码不同"];

        return NO;
    }
    
    if (userNickname.length == 0) {
        [KVNProgress showErrorWithStatus:@"昵称不能为空" ];
        
        return NO;
    }
    
    return YES;
}


#pragma 以下方法为delegate中要求实现的方法
-(void)registerBegin{
    [KVNProgress showProgress:2.0f status:@"正在注册..."];    //加载等待指示器
}

-(void)registerFailed:(NSError *)error{
    [KVNProgress dismiss];
    
    [KVNProgress showSuccessWithStatus:error.description];
}

-(void)registerSuccess{
    [KVNProgress dismiss];
    [KVNProgress showSuccessWithStatus:@"Success"];
    
    UIStoryboard *mainStoreboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ImportCourseStep1VC *importS1VC = [mainStoreboard instantiateViewControllerWithIdentifier:@"importCourseStep1"];
    
    [self.navigationController pushViewController:importS1VC animated:YES];
}

-(void)registerSuccessWithMsg:(NSString *)msg{
    [KVNProgress dismiss];
    [KVNProgress showSuccessWithStatus:msg];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}




//自定义手势触发后的响应方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_userName resignFirstResponder];
    [_userNickname resignFirstResponder];
    [_userPwd resignFirstResponder];
    [_userPwd2 resignFirstResponder];
}

//当点击键盘上的“return”按钮时触发
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//放弃第一响应者身份
    return YES;
}


//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset-36, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}


//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}



@end
