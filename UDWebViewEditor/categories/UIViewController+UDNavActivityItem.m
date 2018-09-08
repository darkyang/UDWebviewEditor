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

- (void)setTitleLabel:(NSString*)title selector:(SEL)selector{
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 0, 60, 20);
    titleLabel.font = [UIFont systemFontOfSize:16.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    [titleLabel addGestureRecognizer:tap];
    titleLabel.userInteractionEnabled = YES;
    self.navigationItem.titleView = titleLabel;
}

- (void)setLeftNavItemWithTitle:(NSString*)title selector:(SEL)selector{
    UIButton *leftBtn = [UIButton buttonWithType:0];
    leftBtn.frame = CGRectMake(0, 0, 50, 27);
    leftBtn.backgroundColor = [UIColor clearColor];
    [leftBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setRightNavItemWithTitle:(NSString*)title selector:(SEL)selector{
    UIButton *rightBtn = [UIButton buttonWithType:0];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = 4.f;
    rightBtn.layer.borderWidth = .5f;
    rightBtn.layer.borderColor = [UIColor blueColor].CGColor;
    rightBtn.backgroundColor = [UIColor clearColor];
    rightBtn.frame = CGRectMake(0, 0, 50, 27);
    [rightBtn setTitle:NSLocalizedString(@"预览", nil) forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nextItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = nextItem;
}

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
