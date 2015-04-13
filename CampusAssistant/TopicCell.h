//
//  TopicCell.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIImageView *zanImg;
@property (weak, nonatomic) IBOutlet UILabel *zanCount;
@property (weak, nonatomic) IBOutlet UIImageView *commentImg;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;

- (IBAction)zan:(id)sender;
- (IBAction)publishComment:(id)sender;


@property int topicId;
@end
