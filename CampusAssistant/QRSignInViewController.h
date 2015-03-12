//
//  QRSignInViewController.h
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-12.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRSignInDelegate.h"
#import "QRSignInBL.h"
#import "ZBarSDK.h"

@interface QRSignInViewController : ZBarReaderViewController<QRSignInDelegate,ZBarReaderDelegate>
@property(strong,nonatomic) QRSignInBL *qrSignInBl;

-(instancetype)init;
@end
