//
//  TopicCommentCell.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "TopicCommentCell.h"

@implementation TopicCommentCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.avatarImg setImage:[UIImage imageNamed:@"ic_biaobiao_jqr_avatar@2x.png"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
