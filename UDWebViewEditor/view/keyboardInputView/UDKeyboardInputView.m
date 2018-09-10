//
//  UDKeyboardInputView.m
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/7.
//  Copyright © 2018年 UD. All rights reserved.
//

#import "UDKeyboardInputView.h"

#define leftMargin 6.f
#define margin 10.f
#define backgroundHeight 50.f

@interface UDKeyboardInputView ()

@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) UDKeyboardInputViewItem *doneItem;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end

@implementation UDKeyboardInputView{
    UDKeyboardInputViewStyle _style;
    NSArray *_icons;
    NSArray *_handlerArray;
    CGFloat _itemWidth;
    CGFloat _itemHeight;
}
#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame
                    itemWidth:(CGFloat)width
                        style:(UDKeyboardInputViewStyle)style
                        icons:(NSArray<NSString*>*)icons
               indicatorTitle:(NSString*)title
                     Handlers:(NSArray<toolbarItemTapHandler>*)handlers{
    self = [super initWithFrame:frame];
    
    _itemWidth = width;
    _itemHeight = width;
    _style = style;
    _icons = icons;
    _handlerArray = handlers;
    
    return self;
}

- (void)setupUIWithFrame:(CGRect)frame title:(NSString*)title{
    if (!_icons || [_icons count] == 0) {
        return;
    }
    if (_style & UDKeyboardInputViewStyleDefault) {
//        [self setupDefaultStyleWithFrame:frame];
    }
    if (_style & UDKeyboardInputViewStyleEdit) {
        [self setupEditStyleWithFrame:frame title:title];
    }
}

- (void)setupEditStyleWithFrame:(CGRect)frame title:(NSString*)title{
    CGRect backgroundFrame;
    if (title.length > 0) {
        backgroundFrame = CGRectMake(0.f, 0.f, SCREEN_WIDTH - (_itemWidth + 80.f), backgroundHeight);
    }else{
        backgroundFrame = CGRectMake(0.f, 0.f, SCREEN_WIDTH - _itemWidth, backgroundHeight);
    }
    //    CGRect backgroundFrame = CGRectMake(0.f, 0.f, SCREEN_WIDTH - (_itemWidth + 80.f), backgroundHeight);
    _containerView = [[UIScrollView alloc] initWithFrame:backgroundFrame];
//    _backgroundView.backgroundColor = [UIColor ColorBackgroundGray];
    [self addSubview:_containerView];
    
    NSInteger count = [_icons count];
    _containerView.contentSize = CGSizeMake(leftMargin + (count-1)*(_itemWidth + margin), 0.f);
    
    UDWeakSelf(self)
    
    CGFloat startX = leftMargin;
    CGFloat startY = 0.f;
    CGFloat itemHeight = backgroundHeight;
    
    for (NSInteger i=0; i<count-1; i++) {
        UDKeyboardInputViewItem *item \
        = [[UDKeyboardInputViewItem alloc] initWithFrame:CGRectMake(startX, startY, _itemWidth, itemHeight)
                                                    icon:[_icons objectAtIndex:i]
                                               iconWidth:28.f
                                              tapHandler:^(UDKeyboardInputViewItem *item) {
                                                  for (UDKeyboardInputViewItem* item in weakself.btnArray) {
                                                      item.iconLabel.textColor = [UIColor blackColor];
                                                  }
                                                  toolbarItemTapHandler handler = [_handlerArray objectAtIndex:i];
                                                  if (handler) {
                                                      handler(item);
                                                  }
                                                  for (UDKeyboardInputViewItem* otherItem in weakself.btnArray) {
                                                      if (otherItem.tag != item.tag) {
                                                          otherItem.isSelected = NO;
                                                      }
                                                  }
                                              }];
        item.tag = i;
        [self.btnArray addObject:item];
        [_containerView addSubview:item];
        startX += (_itemWidth + margin);
    }
    
//    if (title.length > 0) {
//
//        _indicatorLabel = [BKCustomLabel createLabelWithFrame:CGRectMake(SCREEN_WIDTH-80.f-_itemWidth, 11.f, 80.f, 24.f)
//                                                         Font:[UIFont fontMentionText]
//                                                    Alignment:NSTextAlignmentCenter
//                                                         Text:title
//                                                    TextColor:[UIColor colorTextLightGray]
//                                              BackgroundColor:[UIColor ColorBackgroundGray]];
//        [self addSubview:_indicatorLabel];
//    }
    
    _doneItem = [[UDKeyboardInputViewItem alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-_itemWidth, 0.f, _itemWidth, backgroundHeight)
                                                        icon:[_icons lastObject]
                                                   iconWidth:_itemWidth
                                                  tapHandler:^(UDKeyboardInputViewItem *item) {
                                                      toolbarItemTapHandler handler = [_handlerArray lastObject];
                                                      if (handler) {
                                                          handler(item);
                                                      }
                                                  }];
    [self addSubview:_doneItem];
}

#pragma mark -- private methods
- (void)showOnSuperView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.f;
    }];
}

- (void)hideFromSuperView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.f;
    }];
}

- (void)removeFromSuperView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeAllSubViews];
        [self removeFromSuperview];
    }];
}

#pragma mark -- Lazy init
UDLazyLoading(NSMutableArray, btnArray);
@end
