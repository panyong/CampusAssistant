//
//  TopicViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-13.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "TopicViewController.h"
#import "KVNProgress.h"
#import "MJRefresh/MJRefresh.h"
#import "PublishTopicViewController.h"

@interface TopicViewController ()

@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"私密聊";
    
    self.bl = [[TopicBL alloc] init];
    self.bl.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.bl getTopicList];
    
    //下拉刷新
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [self.bl getTopicList];
    }];
    
    
    
    //设置右上角按钮
    UIImage *addImage = [UIImage imageNamed:kTimetable_addCourse_icon];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:addImage style:UIBarButtonItemStylePlain target:self action:@selector(publishTopic:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton animated:YES];
    
//    [self.tableView.legendHeader beginRefreshing];
    // Do any additional setup after loading the view.
}


#pragma mark - 右上角按钮响应事件
-(void)publishTopic:(id)sender{
    PublishTopicViewController *publishTopicVC = [[PublishTopicViewController alloc] initWithNibName:@"PublishTopicViewController" bundle:nil];
    [self.navigationController pushViewController:publishTopicVC animated:YES];
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
    
    cell.topicId = topic.topicId;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}




#pragma mark - TopicBl要求实现的方法
-(void)getTopicListBegin{
    [KVNProgress showWithStatus:@"获取列表ING"];
}

-(void)getTopicListFailed:(NSString *)msg{
    [self.tableView.legendHeader endRefreshing];
    [KVNProgress showErrorWithStatus:msg];
    [KVNProgress dismiss];
}

-(void)getTopicListSuccess:(NSArray *)topicList andCount:(int)count{
    [self.tableView.legendHeader endRefreshing];
    self.topicArray = topicList;
    self.count = count;
    
    [self.tableView reloadData];
    [KVNProgress dismiss];
}

-(void)getTopicListSuccessWithMsg:(NSString *)msg{
    [self.tableView.legendHeader endRefreshing];
    [KVNProgress showErrorWithStatus:msg];
//    [KVNProgress dismiss];
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
