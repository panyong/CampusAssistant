//
//  TopicVC.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "TopicVC.h"
#import "KVNProgress.h"

@interface TopicVC ()

@end

@implementation TopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bl = [[TopicBL alloc] init];
    self.bl.delegate = self;
    
    [self.bl getTopicList];
    // Do any additional setup after loading the view.
}


#pragma mark - tableview要求实现的方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"topicCell";
    
    TopicCell *cell = (TopicCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TopicCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    TopicModel *topic = [self.topicArray objectAtIndex:[indexPath row]];
    
    //初始化Label
    [cell.nickname setText:topic.nickName];
    [cell.publishTime setText:topic.publishTime];
    [cell.content setText:topic.content];
    [cell.zanCount setText:[NSString stringWithFormat:@"%i",topic.zanCount]];
    [cell.commentCount setText:[NSString stringWithFormat:@"%i",topic.commentCount]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}




#pragma mark - TopicBl要求实现的方法
-(void)getTopicListBegin{
    [KVNProgress showWithStatus:@"获取列表ING"];
}

-(void)getTopicListFailed:(NSString *)msg{
    
    [KVNProgress showErrorWithStatus:msg];
    [KVNProgress dismiss];
}

-(void)getTopicListSuccess:(NSArray *)topicList andCount:(int)count{
    self.topicArray = topicList;
    self.count = count;
    [KVNProgress dismiss];
}

-(void)getTopicListSuccessWithMsg:(NSString *)msg{
    [KVNProgress showWithStatus:msg];
    [KVNProgress dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
