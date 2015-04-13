//
//  PublishTopicViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-13.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "PublishTopicViewController.h"

@interface PublishTopicViewController ()

@end

@implementation PublishTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationItem.leftBarButtonItem setTitle:@"取消"];
    
    self.contentTextView.delegate = self;
    
    self.bl = [[TopicBL alloc] init];
    self.bl.delegate = self;
    self.manager = [[ObjectFileManager alloc] init];
    
    //自定义手势，当前VIEW接收到该手势后触发keyboardHide：方法，进行键盘的隐藏
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)publishIt:(id)sender {
    [_contentTextView resignFirstResponder];
    
    UserInfoModel *user = [self.manager getUserInfo];
    
    NSString* userId = user.userId;
    NSString *content = _contentTextView.text;
    
    [_bl publishTopicWithUserId:userId andContent:content];
    
    
}

#pragma mark - TopicDelegate要求实现的方法
-(void)publishTopicBegin{
    NSLog(@"begin");
}
-(void)publishTopicFailed:(NSString *)msg{
    [KVNProgress showErrorWithStatus:msg];
}
-(void)publishTopicSuccess{
    [KVNProgress showSuccessWithStatus:@"发表成功!"];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)publishTopicSuccessWithMsg:(NSString *)msg{
    [KVNProgress showErrorWithStatus:msg];
}


//自定义手势触发后的响应方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_contentTextView resignFirstResponder];
    
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [_contentTextView resignFirstResponder];
    return YES;
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = textView.frame;
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
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
@end
