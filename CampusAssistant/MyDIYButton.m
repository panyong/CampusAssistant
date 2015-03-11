//
//  MyDIYButton.m
//  CampusAssistant
//
//  Created by 潘勇 on 15-3-11.
//  Copyright (c) 2015年 SHIEP. All rights reserved.
//

#import "MyDIYButton.h"

@implementation MyDIYButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(10, 10, contentRect.size.width / 4, contentRect.size.height - 20);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(30 + contentRect.size.width / 4, 30, contentRect.size.width / 2, contentRect.size.height / 4);
}

////返回背景边界
//-(CGRect)backgroundRectForBounds:(CGRect)bounds{
//    
//}
//
////返回content边界
//-(CGRect)contentRectForBounds:(CGRect)bounds{
//    
//}

@end
