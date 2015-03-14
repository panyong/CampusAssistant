//
//  ImportCourseStep1VC.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-4.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "ImportCourseStep1VC.h"
#import "ImportCourseStep2VC.h"

@interface ImportCourseStep1VC ()

@end

@implementation ImportCourseStep1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stuPwd.delegate = self;
    
    self.stuNo.delegate = self;
    
    self.title = @"导入课程第一步";
    
    self.bl = [[ImportCourseBL alloc]init];
    self.bl.delegate = self;
    
    //自定义手势，当前VIEW接收到该手势后触发keyboardHide：方法，进行键盘的隐藏
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma 继续按钮
- (IBAction)nextStep:(id)sender {
    
    if ([self validateText]) {
        [self keyboardHide];
        [self.bl beginStep1RequestWithStuNo:self.stuNo.text andStuPwd:self.stuPwd.text];
        
        NSLog(@"下一步");
    }
}

-(BOOL) validateText{
    NSString *stuNo = self.stuNo.text;
    NSString *stuPwd = self.stuPwd.text;
    
    
    if (stuNo.length == 0) {
        [KVNProgress showErrorWithStatus:@"学号不能为空"];
        
        return NO;
    }
    
    if (stuPwd.length == 0  ) {
        [KVNProgress showErrorWithStatus:@"密码不能为空"];
       
        return NO;
    }
    
    return YES;
}


#pragma 以下方法为importCourseDelegate中要求实现的方法
-(void)step1RequestBegin{
    NSLog(@"doing nothing");
}

-(void)step1RequestFailedWithMsg:(NSString *)msg{
    [KVNProgress showErrorWithStatus:msg];
}

-(void)step1RequestSuccessWithPicData:(NSData *)pic{

    ImportCourseStep2VC *importCourseStep2VC = [[ImportCourseStep2VC alloc] initWithNibName:@"ImportCourseStep2VC" bundle:nil picData:pic];

    [self.navigationController.view addSubview:importCourseStep2VC.view] ;
    [self.navigationController addChildViewController:importCourseStep2VC] ;
}




#pragma 键盘隐藏
//自定义手势触发后的响应方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.stuNo resignFirstResponder];
    [self.stuPwd resignFirstResponder];
}

-(void)keyboardHide{
    [self.stuNo resignFirstResponder];
    [self.stuPwd resignFirstResponder];
}

//当点击键盘上的“return”按钮时触发
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//放弃第一响应者身份
    return YES;
}
@end
