//
//  UIViewController+UDNavActivityItem.m
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/7.
//  Copyright © 2018年 UD. All rights reserved.
//

#import "UIViewController+UDNavActivityItem.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (nonatomic, strong) UIView *backupView;

@property (nonatomic, assign) BOOL activityIndicatorShow;

@end

@implementation UIViewController (UDNavActivityItem)

static const char* const kCustomBackupView = "kCustomBackupView";
static const char* const kCustomActivity = "kCustomActivity";

- (void)showActivityIndicatorViewInNavigationItem{
    UIActivityIndicatorView* aiview = [[UIActivityIndicatorView alloc]
                                       initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    if(!self.activityIndicatorShow){
        self.backupView = self.navigationItem.titleView;
    }
    self.activityIndicatorShow = YES;
    self.navigationItem.titleView = aiview;
    [aiview startAnimating];
}

- (void)hideActivityIndicatorViewInNavigationItem{
    if(self.activityIndicatorShow){
        self.navigationItem.titleView = self.backupView;
    }
}

- (UIView*)backupView{
    return objc_getAssociatedObject(self, kCustomBackupView);
}

- (void)setBackupView:(UIView *)backupView{
    objc_setAssociatedObject(self, kCustomBackupView, backupView, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)activityIndicatorShow{
    return [objc_getAssociatedObject(self, kCustomActivity) boolValue];
}

- (void)setActivityIndicatorShow:(BOOL)activityIndicatorShow{
    objc_setAssociatedObject(self,
                             kCustomActivity,
                             @(activityIndicatorShow),
                             OBJC_ASSOCIATION_ASSIGN);
}

@end
