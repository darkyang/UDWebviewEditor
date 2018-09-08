//
//  UIViewController+UDExtension.m
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/8.
//  Copyright © 2018年 UD. All rights reserved.
//

#import "UIViewController+UDExtension.h"

@interface UIViewController ()<CAAnimationDelegate>

@end

@implementation UIViewController (UDExtension)

- (UIViewController*)currentViewController{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1){
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

- (void)popCurrentViewController{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}


@end
