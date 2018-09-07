//
//  UIView+UDExtension.h
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/7.
//  Copyright © 2018年 UD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UDExtension)

//rec：CGFloat x = CGRectGetMinX(frame);
@property (nonatomic, assign) CGFloat x;
//rec：CGFloat y = CGRectGetMinY(frame);
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//rec：CGFloat width = CGRectGetWidth(frame);
@property (nonatomic, assign) CGFloat width;
//rec：CGFloat height = CGRectGetHeight(frame);
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat bottom;


- (void)removeAllSubViews;

@end
