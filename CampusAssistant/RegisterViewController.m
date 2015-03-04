//
//  RegisterViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-2-3.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "RegisterViewController.h"
#import "InputHelper.h"
#import "DaiDodgeKeyboard.h"
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
    
    self.bl = [LoginAndRegisterBusiness sharedManager];
    self.bl.delegate = self;
    
    UIToolbar *toolBar = [self createToolbar];
    
    for (UIView *v in self.view.subviews) {
        if ([v respondsToSelector:@selector(setText:)]) {
            [v performSelector:@selector(setDelegate:) withObject:self];
            [v performSelector:@selector(setInputAccessoryView:) withObject:toolBar];
        }
    }
    
    [DaiDodgeKeyboard addRegisterTheViewNeedDodgeKeyboard:self.view];
    
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
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    
    if (userPwd.length == 0 || userPwd2.length == 0 ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    
    if (![userPwd2 isEqualToString:userPwd]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码不同" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    
    if (userNickname.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return NO;
    }
    
    return YES;
}


#pragma 以下方法为delegate中要求实现的方法
-(void)registerBegin{
    [KVNProgress showProgress:2.0f status:@"Loading with progress..."];    //加载等待指示器
}

-(void)registerFailed:(NSError *)error{
    [KVNProgress showSuccessWithStatus:error.description];
}

-(void)registerSuccess{
    
    [KVNProgress showSuccessWithStatus:@"Success"];
    
    UIStoryboard *mainStoreboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ImportCourseStep1VC *importS1VC = [mainStoreboard instantiateViewControllerWithIdentifier:@"importCourseStep1"];
    
    [self.navigationController pushViewController:importS1VC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextViewDelegate

-(BOOL) textView : (UITextView*) textView shouldChangeTextInRange : (NSRange) range replacementText : (NSString*) text {
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn : (UITextField*) textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - private

-(UIToolbar*) createToolbar {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextTextField)];
    
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Prev"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(prevTextField)];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(textFieldDone)];
    toolBar.items = @[prevButton, nextButton, space, done];
    
    return toolBar;
    
}

-(void) nextTextField {
    
    NSUInteger currentIndex = [[self inputViews] indexOfObject:[self.view findFirstResponder]];
    
    NSUInteger nextIndex = currentIndex + 1;
    nextIndex += [[self inputViews] count];
    nextIndex %= [[self inputViews] count];
    
    UITextField *nextTextField = [[self inputViews] objectAtIndex:nextIndex];
    
    [nextTextField becomeFirstResponder];
    
}

-(void) prevTextField {
    
    NSUInteger currentIndex = [[self inputViews] indexOfObject:[self.view findFirstResponder]];
    
    NSUInteger prevIndex = currentIndex - 1;
    prevIndex += [[self inputViews] count];
    prevIndex %= [[self inputViews] count];
    
    UITextField *nextTextField = [[self inputViews] objectAtIndex:prevIndex];
    
    [nextTextField becomeFirstResponder];
    
}

-(void) textFieldDone {
    
    [[self.view findFirstResponder] resignFirstResponder];
    
}

-(NSArray*) inputViews {
    
    NSMutableArray *returnArray = [NSMutableArray array];
    
    for (UIView *eachView in self.view.subviews) {
        
        if ([eachView respondsToSelector:@selector(setText:)]) {
            
            [returnArray addObject:eachView];
            
        }
        
    }
    
    return returnArray;
    
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
