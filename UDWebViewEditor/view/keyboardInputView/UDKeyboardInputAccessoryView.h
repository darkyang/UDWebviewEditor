//
//  UDKeyboardInputView.h
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/7.
//  Copyright © 2018年 UD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UDKeyboardInputViewItem.h"

typedef NS_OPTIONS(NSInteger, UDKeyboardInputAccessoryViewStyle){
    UDKeyboardInputAccessoryViewStyleDefault = 1 << 0,
    UDKeyboardInputAccessoryViewStyleIndicatorLabel = 1 << 1,
    UDKeyboardInputAccessoryViewStyleDoneButton = 1 << 2,
    UDKeyboardInputAccessoryViewStyleEdit = UDKeyboardInputAccessoryViewStyleIndicatorLabel | UDKeyboardInputAccessoryViewStyleDoneButton,
};

@interface UDKeyboardInputAccessoryView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    itemWidth:(CGFloat)width
                        style:(UDKeyboardInputAccessoryViewStyle)style
                        icons:(NSArray<NSString*>*)icons
               indicatorTitle:(NSString*)title
                     Handlers:(NSArray<toolbarItemTapHandler>*)handlers;

@end
　　
