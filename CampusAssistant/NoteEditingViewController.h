//
//  NoteEditingViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-15.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectFileManager.h"
#import "NoteEditDelegate.h"
#import "KVNProgress.h"

@interface NoteEditingViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
@property(weak,nonatomic) id<NoteEditDelegate> delegate;

@property NoteModel *note;

@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UITextView *noteContent;
- (IBAction)publishIt:(id)sender;


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil note:(NoteModel*)note;

@property ObjectFileManager *manager;
@end
