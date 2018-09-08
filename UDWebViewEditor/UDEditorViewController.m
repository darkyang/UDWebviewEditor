//
//  UDEditorViewController.m
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/7.
//  Copyright © 2018年 UD. All rights reserved.
//

#import "UDEditorViewController.h"
#import "UDArticleModel.h"

@interface UDEditorViewController ()

@property (nonatomic, strong) UDArticleModel *articleModel;

@end

@implementation UDEditorViewController{
    
    /*status*/
    BOOL _keyboardVisible;
    BOOL _keyboardIsChanging;
    BOOL _keyboardSpanViewHide;
    BOOL _activityIndicatorShow;
}

#pragma mark -- life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    
}

#pragma mark -- init methods
- (void)addNotifications{
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initNavBar{
    [self setTitleLabel:NSLocalizedString(@"UDEditor", nil) selector:@selector(tapTitle:)];
    [self setLeftNavItemWithTitle:NSLocalizedString(@"取消", nil) selector:@selector(cancelEdit:)];
    [self setRightNavItemWithTitle:NSLocalizedString(@"预览", nil) selector:@selector(nextStep:)];
}

#pragma mark -- event handler - navbar
- (void)tapTitle:(id)selector{
    
}

- (void)cancelEdit:(id)selector{
    if (self.articleModel.title.trimmedString.length == 0 \
        && self.articleModel.content.trimmedString.length == 0) {
        [self popCurrentViewController];
        return;
    }
    UDWeakSelf(self)
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
}

- (void)nextStep:(id)selector{
    
}

#pragma mark -- event handler -keyboard
- (void)keyboardDidHide{
    _keyboardVisible = NO;
    _keyboardIsChanging = NO;
}

- (void)keyboardDidShow{
    _keyboardVisible = YES;
    _keyboardIsChanging = NO;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    if (![[self currentViewController] isKindOfClass:[UDEditorViewController class]]) {
        return;
    }
    
    if (_keyboardIsChanging) {
        return;
    }
    _keyboardIsChanging = YES;
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
//    _keyboardHeight = keyboardF.size.height;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
//    if (IsiPhoneX) {
//        self.toolbarContainerView.originY = keyboardF.origin.y - _toolbarHeight + 45.f;
//        self.toolbarContainerView.height = _toolbarHeight;
//    }else{
//        self.toolbarContainerView.originY = keyboardF.origin.y - _toolbarHeight;
//    }
//    [self.keyboardSpanView setDoneItemIcon:BK_ICONFONT_HIDE];
    
    // commit animations
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification{
//    if (![[self currentViewController] isKindOfClass:[BKBlogEditorViewController class]]) {
//        return;
//    }
//    NSDictionary *userInfo = notification.userInfo;
//    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    _keyboardHeight = 0.f;
//
//    [self resetToolbarWithDuration:duration];
//
//    _keyboardInputType = 0;
}

@end
