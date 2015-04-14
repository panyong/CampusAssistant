//
//  TopicDetailViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-4-14.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "KVNProgress.h"

@interface TopicDetailViewController ()

@end

@implementation TopicDetailViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil topicId:(int)topicId{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.topicId = topicId;
        self.bl = [[CommentBL alloc] init];
        self.bl.delegate = self;
        
        self.manager = [[ObjectFileManager alloc] init];
        
//        self.view.frame = self.parentViewController.view.frame;
        
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    
    [self.commentTableView addLegendHeaderWithRefreshingBlock:^{
        [_bl getTopicModelById:_topicId];
    }];
    [self.commentTableView.legendHeader beginRefreshing];
    
    //自定义手势，当前VIEW接收到该手势后触发keyboardHide：方法，进行键盘的隐藏
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    self.commentFiled.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - CommenDelegate要求实现的方法
-(void)getTopicModelBegin{
    
}
-(void)getTopicModelFailed:(NSString *)msg{
    [self.commentTableView.legendHeader endRefreshing];
    
    [KVNProgress showErrorWithStatus:msg];
}

-(void)getTopicModelSuccessWithMsg:(NSString *)msg{
    [self.commentTableView.legendHeader endRefreshing] ;
    [KVNProgress showErrorWithStatus:msg];
}

-(void)getTopicModelSuccessWithTopicModel:(TopicModel *)topic commentList:(NSArray *)commentList{
    [self.commentTableView.legendHeader endRefreshing] ;
    
    _topic = topic;
    _comment = commentList;
    
    [self.commentTableView reloadData];
    
    [self.avatarImg setImage:[UIImage imageNamed:@"ic_biaobiao_jqr_avatar@2x.png"]];
    [self.zanImg setImage:[UIImage imageNamed:@"pic_th_icon_hehe@2x.png"]];
    [self.commentImg setImage:[UIImage imageNamed:@"pic_th_comment@2x.png"]];
    
    [_nickname setText:topic.nickName] ;
    [_publishTime setText:topic.publishTime];
    [_content setText:topic.content];
    [_zanCount setText:[NSString stringWithFormat:@"%i",topic.zanCount]];
    [_commentCount setText:[NSString stringWithFormat:@"%i",topic.commentCount]];
}

-(void)publishCommentBegin{
    
}

-(void)publishCommentFailed:(NSString *)msg{
    [KVNProgress showErrorWithStatus:msg];
}

-(void)publishCommentSuccess{
    [_commentTableView.legendHeader beginRefreshing];
}

-(void)publishCommentSuccessWithMsg:(NSString *)msg{
    [KVNProgress  showErrorWithStatus:msg];
}

#pragma mark - TableView要求实现的方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topic.commentCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"topicCommentCell";
    
    TopicCommentCell *cell = (TopicCommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TopicCommentCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    CommentModel *comment = [self.comment objectAtIndex:indexPath.row];
    
    //初始化Label
    [cell.nickname setText:comment.nickName];
    [cell.publishTime setText:comment.publishTime];
    [cell.commentContent setText:comment.commentContent];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义手势触发后的响应方法
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_commentFiled resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_commentFiled resignFirstResponder];
    return YES;
}


- (IBAction)publishComment:(id)sender {
    UserInfoModel *user = [_manager getUserInfo];
    NSString *comment = _commentFiled.text;
    
    [_commentFiled setText:@""];
    
    [_bl publishCommentWithTopicId:_topicId userId:user.userId content:comment];
    
    NSLog(@"发布评论");
}
@end
