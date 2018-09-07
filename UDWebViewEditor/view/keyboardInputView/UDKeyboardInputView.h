//
//  UDKeyboardInputView.h
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/7.
//  Copyright © 2018年 UD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, UDKeyboardInputViewStyle){
    UDKeyboardInputViewStyleDefault = 1 << 0,
    UDKeyboardInputViewStyleIndicatorLabel = 1 << 1,
    UDKeyboardInputViewStyleDoneButton = 1 << 2,
    UDKeyboardInputViewStyleEdit = UDKeyboardInputViewStyleIndicatorLabel | UDKeyboardInputViewStyleDoneButton,
};

@interface UDKeyboardInputView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    itemWidth:(CGFloat)width
                        style:(UDKeyboardInputViewStyle)style
                        icons:(NSArray*)icons
               indicatorTitle:(NSString*)title
                     Handlers:(NSArray*)handlers;

@end
