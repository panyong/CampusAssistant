//
//  ViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-26.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginAndRegisterDelegate.h"
#import "LoginAndRegisterBusiness.h"
#import "ObjectFileDelegate.h"
#import "YYAnimationIndicator.h"

@interface ViewController : UIViewController<UITextFieldDelegate,LoginAndRegisterDelegate,ObjectFileDelegate>
{
    BOOL keyboardVisible;
}
@property(strong,nonatomic) YYAnimationIndicator *activity;
@property(strong,nonatomic) LoginAndRegisterBusiness* bl;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)presentRegisterView:(id)sender;
- (IBAction)login:(id)sender;

@end
