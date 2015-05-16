//
//  FindViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-1-27.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "FindViewController.h"
#import "MyDIYButton.h"
#import "ImageConfig.h"
#import "QRSignInViewController.h"
#import "ShakeItViewController.h"
#import "TopicViewController.h"
#import "NotepadViewController.h"
#import "EventViewController.h"

@interface FindViewController ()


//@property(strong,nonatomic) MyDIYButton *TalkAfterClass;

@end

@implementation FindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.delegate = self;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kFind_background_image] ]];
    
    self.edgesForExtendedLayout = UIRectEdgeNone ;//设置view大小
    
    MyDIYButton *talkAfterClassBtn = [self getDIYButtonByImageName:kFind_treehole_icon title:@"树洞私密聊" index:1];
    [talkAfterClassBtn addTarget:self action:@selector(talkAfterClass:) forControlEvents:UIControlEventTouchUpInside];
    
    MyDIYButton *cengkeBtn = [self getDIYButtonByImageName:kFind_cengke_icon title:@"摇一摇蹭课" index:2];
    [cengkeBtn addTarget:self action:@selector(cengke:) forControlEvents:UIControlEventTouchUpInside];
    
    MyDIYButton *qrSignInBtn = [self getDIYButtonByImageName:kFind_qr_sign_in_icon title:@"二维码签到" index:3];
    [qrSignInBtn addTarget:self action:@selector(qrSignIn:) forControlEvents:UIControlEventTouchUpInside];
    
    MyDIYButton *noteBtn = [self getDIYButtonByImageName:@"pic_find_note@2x.png" title:@"随手记" index:4];
    [noteBtn addTarget:self action:@selector(noteView:) forControlEvents:UIControlEventTouchUpInside];
    
    MyDIYButton *eventBtn = [self getDIYButtonByImageName:@"pic_find_countdown@2x.png" title:@"倒计时" index:5];
    [eventBtn addTarget:self action:@selector(eventView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:talkAfterClassBtn];
    [self.scrollView addSubview:cengkeBtn];
    [self.scrollView addSubview:qrSignInBtn];
    [self.scrollView addSubview:noteBtn];
    [self.scrollView addSubview:eventBtn];
    
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, eventBtn.frame.size.width * 2+20)];
    self.scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
    
     self.title = @"发现";
    
    
}

-(void)eventView:(id)sender{
    NSLog(@"随手记");
    EventViewController *eventVC = [[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];
    [self.navigationController pushViewController:eventVC animated:YES];
}

-(void)noteView:(id)sender{
    NSLog(@"随手记");
    NotepadViewController *notePadVC = [[NotepadViewController alloc] initWithNibName:@"NotepadViewController" bundle:nil];
    [self.navigationController pushViewController:notePadVC animated:YES];
}

#pragma mark - 下课聊响应函数
-(void)talkAfterClass:(id)sender{
    NSLog(@"树洞私密聊");
    TopicViewController *topicVC = [[TopicViewController alloc] initWithNibName:@"TopicViewController" bundle:nil];
        
    [self.navigationController pushViewController:topicVC animated:YES];
}

#pragma mark - 摇一摇蹭课响应函数
-(void)cengke:(id)sender{
    
    ShakeItViewController *shakeItVC = [[ShakeItViewController alloc] initWithNibName:@"ShakeItViewController" bundle:nil];
    
    [self.navigationController pushViewController:shakeItVC animated:YES];
    
    NSLog(@"摇一摇蹭课");
}

#pragma mark - 二维码签到响应函数
-(void)qrSignIn:(id)sender{
    NSLog(@"二维码签到");
    QRSignInViewController *qrSignInVC = [[QRSignInViewController alloc] init];
    
    [self.navigationController pushViewController:qrSignInVC animated:YES];
}

#pragma mark - 获取自定义按钮的位置等
-(MyDIYButton *) getDIYButtonByImageName:(NSString *)imageName title:(NSString *)title index:(int)index{
    CGFloat btnX = self.view.frame.origin.x + 5;
    CGFloat btnY = self.view.frame.origin.y + 10 +  (self.view.frame.size.height / 6 + 10) * (index - 1);
    CGFloat btnWidth = self.view.frame.size.width - 10;
    CGFloat btnHeight = self.view.frame.size.height / 6;
    
    
    MyDIYButton *btn = [[MyDIYButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnWidth, btnHeight)];//
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithWhite:0.96 alpha:0.9]];
    
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:5.0];
    [btn.layer setBorderWidth:0.3];
    
    return btn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
