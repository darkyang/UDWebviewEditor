//
//  UDKeyboardInputView.m
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/7.
//  Copyright © 2018年 UD. All rights reserved.
//

#import "UDKeyboardInputView.h"

@interface UDKeyboardInputView ()

@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end

@implementation UDKeyboardInputView{
    NSArray *_icons;
    NSArray *_handlerArray;
    CGFloat _itemWidth;
    CGFloat _itemHeight;
}

#pragma mark -- init

#pragma mark -- Lazy init
UDLazyLoading(NSMutableArray, btnArray);
@end
