//
//  PublishTopicViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-13.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicBL.h"
#import "ObjectFileManager.h"
#import "UserInfoModel.h"
#import "KVNProgress.h"

@interface PublishTopicViewController : UIViewController<UITextViewDelegate,TopicDelegate>

@property(strong,nonatomic) TopicBL *bl;
@property ObjectFileManager* manager;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
- (IBAction)publishIt:(id)sender;
@end
