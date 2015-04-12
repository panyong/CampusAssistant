//
//  QRSignInViewController.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "QRSignInViewController.h"
#import "KVNProgress.h"

@interface QRSignInViewController ()

@end

@implementation QRSignInViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.qrSignInBl = [[QRSignInBL alloc] init];
        self.qrSignInBl.delegate = self;
        
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫一扫签到";
    
    self.readerDelegate = self;
    
    self.manager = [[ObjectFileManager alloc] init];
    
//    self.view.frame =  CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y , self.view.frame.size.width, self.view.frame.size.height + 20);
    
    [self setOverlayPickerView];
    
//    [self.scanner setSymbology: ZBAR_I25
//     
//                   config: ZBAR_CFG_ENABLE
//     
//                       to: 0];
    
   
    
    
}


#pragma mark -  绘制自定义扫描界面
- (void)setOverlayPickerView{
    
    //清除原有控件
    
    for (UIView *temp in [self.view subviews]) {
        
        for (UIButton *button in [temp subviews]) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                
                [button removeFromSuperview];
                
            }
            
        }
        
        for (UIToolbar *toolbar in [temp subviews]) {
            
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                
                [toolbar setHidden:YES];
                
                [toolbar removeFromSuperview];
                
            }
            
        }
        
    }
    
    CGFloat height1 = (self.view.frame.size.height-30) / 3;
    CGFloat width1 = self.view.frame.size.width;
    CGFloat height2 = height1;
    CGFloat width2 = self.view.frame.size.width / 3;
    
    //画中间的基准线
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(width2 - 30, 30 + height1, width2 + 60, 1)];
    
    line.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:line];
    
    [self moveLineAnimation:line height:height1];
//    [UIView ]
    
    //最上部view
    
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, width1, height1)];
    
    upView.alpha = 0.3;
    
    upView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:upView];
    
    //用于说明的label
    
    UILabel * labIntroudction= [[UILabel alloc] init];
    
    labIntroudction.backgroundColor = [UIColor clearColor];
    
    labIntroudction.frame=CGRectMake(10, 80, 290, 50);
    
    labIntroudction.numberOfLines=2;
    
    labIntroudction.textColor=[UIColor whiteColor];
    
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    
    [self.view addSubview:labIntroudction];
    
    
    //左侧的view
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 30+height1, width2 - 30 , height2)];
    
    leftView.alpha = 0.3;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:leftView];

    
    //右侧的view
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(width2 * 2 + 30, 30 + height1  , width2, height2)];
    
    rightView.alpha = 0.3;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:rightView];
    
    
    //底部view
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 + height1 * 2,width1,height1 + 30)];
    
    downView.alpha = 0.3;
    
    downView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:downView];
    
    
    
}

//uiview动画
- (void)moveLineAnimation:(UIView* )line height:(CGFloat)height{
    __weak QRSignInViewController *wSelf = self;
    if (line.frame.origin.y >= (30 + height*2)) {
        CGRect rect = line.frame;
        rect.origin.y = 30 + height;
        line.frame = rect;
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = line.frame;
        rect.origin.y = rect.origin.y + 15;
        line.frame = rect;
    } completion:^(BOOL finished) {
        if (finished) {
            [wSelf moveLineAnimation:line height:height];
        }
    }];
}



//该方法为ZBarReaderDelegate中得方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol * symbol;
    for(symbol in results)
        break;
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *courseId = symbol.data;
    
    UserInfoModel *user = [self.manager getUserInfo];
    
    [self.qrSignInBl signInWithCourseId:courseId userId:user.userId];
    
    NSLog(@"content:%@",courseId);
}

#pragma mark - 以下方法为QRSignInDelegate要求实现的方法
-(void)signInBegin{
    [KVNProgress showProgress:1.0 status:@"签到ing"];
}

-(void)signInFailed:(NSString *)msg{
    [KVNProgress showErrorWithStatus:@"网络出小差了~~"];
}

-(void)signInSuccess:(NSString *)msg{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [KVNProgress showSuccessWithStatus:msg];
}
-(void)signInSuccessWithMsg:(NSString *)msg{
    [KVNProgress showSuccessWithStatus:msg];
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
