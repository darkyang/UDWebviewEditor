//
//  UDKeyboardInputViewItem.m
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/8.
//  Copyright © 2018年 UD. All rights reserved.
//

#import "UDKeyboardInputViewItem.h"

@implementation UDKeyboardInputViewItem

- (instancetype)initWithFrame:(CGRect)frame icon:(NSString*)icon iconWidth:(CGFloat)width tapHandler:(toolbarItemTapHandler)handler{
    self = [super initWithFrame:frame];
    _iconWidth = width;
    _tapHandler = handler;
    self.isSelected = NO;
    [self setupItemWithIcon:icon];
    return self;
}

- (void)setupItemWithIcon:(NSString*)icon{
    CGFloat startX = (self.width - _iconWidth)/2;
    CGFloat startY = (self.height - _iconWidth)/2;
    
    _iconLabel = [UILabel new];
    _iconLabel.frame = CGRectMake(startX, startY, _iconWidth, _iconWidth);
    _iconLabel.font = [UIFont fontWithName:@"icon_font" size:30.f];
    _iconLabel.textAlignment = NSTextAlignmentCenter;
    _iconLabel.text  = icon;
    _iconLabel.textColor = [UIColor blackColor];
    _iconLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_iconLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
         
- (void)tap:(UIGestureRecognizer*)geseture{
    if (self.tapHandler) {
        self.tapHandler(self);
    }
    if (self.isSelected) {
        [self.iconLabel setTextColor:[UIColor blueColor]];
    }else{
        [self.iconLabel setTextColor:[UIColor blackColor]];
    }
}

- (void)setIcon:(NSString *)icon{
    [self.iconLabel setText:icon];
}

@end
