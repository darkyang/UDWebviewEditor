//
//  UDKeyboardInputViewItem.h
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/8.
//  Copyright © 2018年 UD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UDKeyboardInputViewItem;
typedef void (^toolbarItemTapHandler)(UDKeyboardInputViewItem *item);

@interface UDKeyboardInputViewItem : UIView

@property (nonatomic, strong) UILabel *iconLabel;
@property (nonatomic, copy) toolbarItemTapHandler tapHandler;
@property (nonatomic, assign) CGFloat iconWidth;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initWithFrame:(CGRect)frame
                         icon:(NSString*)icon
                    iconWidth:(CGFloat)width
                   tapHandler:(toolbarItemTapHandler)handler;

- (void)setIcon:(NSString *)icon;

@end
