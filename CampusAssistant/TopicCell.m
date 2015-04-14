//
//  TopicCell.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "TopicCell.h"
#import "ImageConfig.h"
#import "KVNProgress.h"

@implementation TopicCell

- (void)awakeFromNib {
    // Initialization code
    if (self) {
        [self.headImg setImage:[UIImage imageNamed:@"ic_biaobiao_jqr_avatar@2x.png"]];
        [self.zanImg setImage:[UIImage imageNamed:@"pic_th_icon_hehe@2x.png"]];
        [self.commentImg setImage:[UIImage imageNamed:@"pic_th_comment@2x.png"]];
        [self.nickname setNumberOfLines:0];
        [self.nickname setAdjustsFontSizeToFitWidth:YES];
        [self.publishTime setNumberOfLines:0];
        [self.publishTime setAdjustsFontSizeToFitWidth:YES];
        
        self.bl = [[ZanBL alloc] init];
        self.bl.delegate = self;

        self.manager = [[ObjectFileManager alloc] init];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)zan:(id)sender {
    NSLog(@"zan+1 TopicId:%i",self.topicId);
    
    UserInfoModel *user =[self.manager getUserInfo];
    NSString* userId = user.userId;
//    NSString* topicId = [NSString stringWithFormat:@"%i",_topicId];
    
    [_bl zanWithUserId:userId andTopicId:_topicId];
    
}

- (IBAction)publishComment:(id)sender {
//    NSLog(@"comment TopicId:%i",self.topicId);
    [self.delegate commentSuccessInCell:self];
}


#pragma mark - ZanDelegate要求实现的方法
-(void)publishZanBegin{
    
}

-(void)publishZanFailed:(NSString *)msg{
    [KVNProgress showErrorWithStatus:msg];
}

-(void)publishZanSuccess{
    [self.delegate zanSuccessInCell:self];
}

-(void)publishZanSuccessWithMsg:(NSString *)msg{
    [KVNProgress showErrorWithStatus:msg];
}
@end
