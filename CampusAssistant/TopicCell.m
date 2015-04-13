//
//  TopicCell.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "TopicCell.h"
#import "ImageConfig.h"

@implementation TopicCell

- (void)awakeFromNib {
    // Initialization code
    if (self) {
        [self.zanImg setImage:[UIImage imageNamed:kFind_topic_zan_icon]];
        [self.commentImg setImage:[UIImage imageNamed:kFind_topic_comment_icon]];
        
        [self.nickname setNumberOfLines:0];
        [self.nickname setAdjustsFontSizeToFitWidth:YES];
        [self.publishTime setNumberOfLines:0];
        [self.publishTime setAdjustsFontSizeToFitWidth:YES];
        [self.content setNumberOfLines:0];
        [self.content setAdjustsFontSizeToFitWidth:YES];
        [self.zanCount setNumberOfLines:0];
        [self.zanCount setAdjustsFontSizeToFitWidth:YES];
        [self.commentCount setNumberOfLines:0];
        [self.commentCount setAdjustsFontSizeToFitWidth:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)zan:(id)sender {
    NSLog(@"zan+1 TopicId:%i",self.topicId);
}

- (IBAction)publishComment:(id)sender {
    NSLog(@"comment TopicId:%i",self.topicId);
}
@end
