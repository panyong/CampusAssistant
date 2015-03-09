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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"学号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    
    if (stuPwd.length == 0  ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
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
//    [self.view endEditing:NO];
//    [self initMyView:pic];
    ImportCourseStep2VC *importCourseStep2VC = [[ImportCourseStep2VC alloc] initWithNibName:@"ImportCourseStep2VC" bundle:nil picData:pic];
//    [importCourseStep2VC initImageData:pic];
    //[self.navigationController pushViewController:importCourseStep2VC animated:YES];
    [self.navigationController.view addSubview:importCourseStep2VC.view] ;
    [self.navigationController addChildViewController:importCourseStep2VC] ;
}

#pragma 绘制自定义视图 已废弃
-(void) initMyView:(NSData*)pic{
    UIView *modeView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    modeView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3] ;
    
    
    UIView *nextView = [[UIView alloc] initWithFrame:CGRectMake(10, 180, 300, 200)] ;
    nextView.backgroundColor = [UIColor whiteColor] ;
    
//    //Label
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 160, 30)];
    tipLabel.text = @"请输入验证码";
    
    [nextView addSubview:tipLabel];
//
//    //Img view
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 60, 40, 20)];
    UIImage *codeImage = [UIImage imageWithData:pic];
    [imgView setImage:codeImage];
    [nextView addSubview:imgView];
    
    //textField
    UITextField *verifyCodeField = [[UITextField alloc] initWithFrame:CGRectMake(70, 90, 90, 30)];
    [verifyCodeField setBackgroundColor:[UIColor grayColor]];
    [nextView addSubview:verifyCodeField];
    
    //nextBtn
//    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 150, 50, 40)];
//    [nextBtn setTitle:@"确定" forState:UIControlStateNormal];
//    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
//    [dataDic setObject:verifyCodeField forKey:@"verifyCodeField"];
//    [dataDic setObject:modeView forKey:@"modeView"];
//    
//    [nextBtn addTarget:self action:@selector(nextStep4Course:) forControlEvents:UIControlEventTouchUpInside];
//    [nextView addSubview:nextBtn];
    
    [modeView addSubview:nextView] ;
    
    [self.navigationController.view addSubview:modeView] ;

}

-(void) nextStep4Course:(UIView*) modeView{
 
    NSLog(@"modeView:%@",modeView);
    
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
