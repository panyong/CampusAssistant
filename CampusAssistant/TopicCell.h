//
//  TopicCell.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZanBL.h"
#import "ObjectFileManager.h"
#import "UserInfoModel.h"
#import "TopicCellDelegate.h"

@interface TopicCell : UITableViewCell<ZanDelegate>
@property(weak,nonatomic) id<TopicCellDelegate> delegate;

@property(strong,nonatomic) ZanBL *bl;
@property(strong,nonatomic) ObjectFileManager *manager;


@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *zanImg;
@property (weak, nonatomic) IBOutlet UILabel *zanCount;
@property (weak, nonatomic) IBOutlet UIImageView *commentImg;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;

- (IBAction)zan:(id)sender;
- (IBAction)publishComment:(id)sender;


@property int topicId;
@property int zanCountTemp;
@property int commentCountTemp;
@end
