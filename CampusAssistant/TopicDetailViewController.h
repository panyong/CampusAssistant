//
//  TopicDetailViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh/MJRefresh.h"
#import "CommentBL.h"
#import "TopicCommentCell.h"
#import "ObjectFileManager.h"

@interface TopicDetailViewController : UIViewController<CommentDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIImageView *zanImg;
@property (weak, nonatomic) IBOutlet UILabel *zanCount;
@property (weak, nonatomic) IBOutlet UIImageView *commentImg;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UITextField *commentFiled;

@property(strong,nonatomic) CommentBL *bl;
@property ObjectFileManager *manager;

@property CGRect textFrame;
@property TopicModel *topic;
@property NSArray *comment;

@property int topicId;

- (IBAction)publishComment:(id)sender;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil topicId:(int) topicId;

@end
