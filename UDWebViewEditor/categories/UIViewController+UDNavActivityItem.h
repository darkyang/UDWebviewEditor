//
//  UIViewController+UDNavActivityItem.h
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/7.
//  Copyright © 2018年 UD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (UDNavActivityItem)

- (void)setTitleLabel:(NSString*)title selector:(SEL)selector;

- (void)setLeftNavItemWithTitle:(NSString*)title selector:(SEL)selector;

- (void)setRightNavItemWithTitle:(NSString*)title selector:(SEL)selector;

- (void)showActivityIndicatorViewInNavigationItem;

- (void)hideActivityIndicatorViewInNavigationItem;

@end
