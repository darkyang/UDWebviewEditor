//
//  BKEditorFormatbarView.m
//  EditorDemo
//
//  Created by mac_work_zhao on 2018/3/15.
//  Copyright © 2018年 Automattic, Inc. All rights reserved.
//

#import "WPEditorFormatbarView.h"
#import "WPEditorToolbarButton.h"
#import "ZSSBarButtonItem.h"

const CGFloat WPEditorFormatbarViewToolbarHeight = 44;

@interface BKEditorFormatbarView()

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) NSMutableArray *barItems;

@end

@implementation BKEditorFormatbarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self initFoldButton];
    [self initImageBarButton];
    [self initAtButton];
    [self initTagButton];
//    [self initFlexButton];
    [self addSubview:self.toolbar];
    _toolbar.items = self.barItems;
//    [_toolbar setItems:self.barItems];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // HACK: Sergio Estevao (2017-10-10): Change the size of the items whe running on a device with a width smaller or equal than 320 (iPhone SE)
    if (self.frame.size.width <= 320) {
        for (UIBarButtonItem *item in self.toolbar.items) {
            item.width = 44;
        }
    }
}

- (void)initFoldButton{
    NSString* accessibilityLabel = NSLocalizedString(@"Fold Keyboard",
                                                     @"Accessibility label for block quote button on formatting toolbar.");
    
    [self initwithTag:kBKEditorViewControllerElementTagFoldKeyboard
         htmlProperty:nil
            imageName:@"fold"
               target:self
             selector:@selector(changeKeyboardFrame:)
   accessibilityLabel:accessibilityLabel];
}

- (void)initImageBarButton{
    NSString* accessibilityLabel = NSLocalizedString(@"Insert Image",
                                                     @"Accessibility label for insert image button on formatting toolbar.");
    [self initwithTag:kBKEditorViewControllerElementTagInsertImage
         htmlProperty:@"image"
            imageName:@"img"
               target:self
             selector:@selector(insertImage:)
   accessibilityLabel:accessibilityLabel];
}

- (void)initAtButton{
    NSString* accessibilityLabel = NSLocalizedString(@"At User",
                                                     @"Accessibility label for at user button on formatting toolbar.");
    
    [self initwithTag:kBKEditorViewControllerElementTagAtPerson
         htmlProperty:@"bk-user"
            imageName:@"@"
               target:self
             selector:@selector(atUser:)
   accessibilityLabel:accessibilityLabel];
}

- (void)initTagButton{
    NSString* accessibilityLabel = NSLocalizedString(@"Add Tag",
                                                     @"Accessibility label for at Add tag button on formatting toolbar.");
    
    [self initwithTag:kBKEditorViewControllerElementTagInsertTag
         htmlProperty:nil
            imageName:@"tag"
               target:self
             selector:@selector(insertTag:)
   accessibilityLabel:accessibilityLabel];
}

- (void)initFlexButton{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [self.barItems addObject:item];
}

- (void)changeKeyboardFrame:(UIBarButtonItem*)barItem{
    if ([self.delegate respondsToSelector:@selector(editorToolbarView:changeKeyboard:)]) {
        [self.delegate editorToolbarView:self changeKeyboard:barItem];
    }
}

- (void)insertImage:(UIBarButtonItem*)barItem{
    if ([self.delegate respondsToSelector:@selector(editorToolbarView:insertImage:)]) {
        [self.delegate editorToolbarView:self insertImage:barItem];
    }
}

- (void)atUser:(UIBarButtonItem*)barItem{
    if ([self.delegate respondsToSelector:@selector(editorToolbarView:atUser:)]) {
        [self.delegate editorToolbarView:self atUser:barItem];
    }
}

- (void)insertTag:(UIBarButtonItem*)barItem{
    if ([self.delegate respondsToSelector:@selector(editorToolbarView:addTag:)]) {
        [self.delegate editorToolbarView:self addTag:barItem];
    }
}

#pragma mark - Toolbar: buttons
- (void)initwithTag:(BKEditorViewControllerElementTag)tag
       htmlProperty:(NSString*)htmlProperty
          imageName:(NSString*)imageName
             target:(id)target
           selector:(SEL)selector
 accessibilityLabel:(NSString*)accessibilityLabel{
    WPEditorToolbarButton* customButton = [[WPEditorToolbarButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 50, 50)];
    customButton.titleLabel.font = [UIFont fontWithName:@"icon_font" size:24.f];
    [customButton setTitle:imageName forState:UIControlStateNormal];
    [customButton setTitle:imageName forState:UIControlStateSelected];
    customButton.normalTintColor = self.itemTintColor;
    customButton.selectedTintColor = self.itemSelectedTintColor;
    customButton.disabledTintColor = self.itemUnableTintColor;
    customButton.backgroundColor = [UIColor redColor];
    customButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [customButton addTarget:target
                     action:selector
           forControlEvents:UIControlEventTouchUpInside];
    
    ZSSBarButtonItem *barButtonItem = [[ZSSBarButtonItem alloc] initWithCustomView:customButton];
    barButtonItem.style = UIBarButtonItemStylePlain;
    barButtonItem.tag = tag;
    if (htmlProperty.length != 0) {
        barButtonItem.htmlProperty = htmlProperty;
    }
    barButtonItem.accessibilityLabel = accessibilityLabel;
    [self.barItems addObject:barButtonItem];
}

- (void)setItemTintColor:(UIColor *)itemTintColor
{
    _itemTintColor = itemTintColor;
    
    for (UIBarButtonItem *item in self.toolbar.items) {
        if ([item isKindOfClass:[ZSSBarButtonItem class]]) {
            WPEditorToolbarButton *wpButton = (WPEditorToolbarButton*)item.customView;
            wpButton.normalTintColor = _itemTintColor;
        }
    }
}

- (void)setDisabledItemTintColor:(UIColor *)disabledItemTintColor
{
    _itemUnableTintColor = disabledItemTintColor;
    
    for (UIBarButtonItem *item in self.toolbar.items) {
        if ([item isKindOfClass:[ZSSBarButtonItem class]]) {
            WPEditorToolbarButton *wpButton = (WPEditorToolbarButton*)item.customView;
            wpButton.disabledTintColor = _itemUnableTintColor;
        }
    }
}

- (void)setSelectedItemTintColor:(UIColor *)selectedItemTintColor
{
    _itemSelectedTintColor = selectedItemTintColor;
    
    for (UIBarButtonItem *item in self.toolbar.items) {
        if ([item isKindOfClass:[ZSSBarButtonItem class]]) {
            WPEditorToolbarButton *wpButton = (WPEditorToolbarButton*)item.customView;
            wpButton.selectedTintColor = _itemSelectedTintColor;
        }
    }
}

- (UIBarButtonItem *)toolbarItemWithTag:(BKEditorViewControllerElementTag)tag
{
    // Find whichever toolbar is currently installed in the view hierarchy.
    UIToolbar *toolbar;
    if (self.toolbar.window) {
        toolbar = self.toolbar;
    }
    if (toolbar) {
        for (ZSSBarButtonItem *item in toolbar.items) {
            if (item.tag == tag) {
                return item;
            }
        }
    }
    return nil;
}

- (void)toolbarItemWithTag:(BKEditorViewControllerElementTag)tag setVisible:(BOOL)visible
{
    for (ZSSBarButtonItem *item in self.toolbar.items) {
        if (item.tag == tag) {
            item.customView.hidden = !visible;
        }
    }
}

- (void)toolbarItemWithTag:(BKEditorViewControllerElementTag)tag setSelected:(BOOL)selected
{
    for (ZSSBarButtonItem *item in self.toolbar.items) {
        if (item.tag == tag) {
            item.selected = selected;
        }
    }
}

- (void)toggleSelectionForToolbarItemWithTag:(BKEditorViewControllerElementTag)tag
{
    for (ZSSBarButtonItem *item in self.toolbar.items) {
        if (item.tag == tag) {
            item.selected = !item.selected;
        }
    }
}

- (void)enableToolbarItems:(BOOL)enable{
    for (ZSSBarButtonItem *item in self.toolbar.items) {
        item.enabled = enable;
        if (!enable) {
            [item setSelected:NO];
        }
    }
}

- (void)clearSelectedToolbarItems
{
    for (ZSSBarButtonItem *item in self.toolbar.items) {
        [item setSelected:NO];
    }
}

- (void)selectToolbarItemsForStyles:(NSArray*)styles
{
    for (UIBarButtonItem *item in self.toolbar.items) {
        if ([item isKindOfClass:[ZSSBarButtonItem class]]) {
            ZSSBarButtonItem* zssItem = (ZSSBarButtonItem*)item;
            
            if ([styles containsObject:zssItem.htmlProperty]) {
                zssItem.selected = YES;
            } else {
                zssItem.selected = NO;
            }
        }
    }
}

- (UIToolbar*)toolbar{
    if (_toolbar == nil) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        _toolbar.barTintColor = self.backgroundColor;
        _toolbar.translucent = NO;
        _toolbar.clipsToBounds = YES;
    }
    return _toolbar;
}

- (NSMutableArray*)barItems{
    if (!_barItems) {
        _barItems = [NSMutableArray array];
    }
    return _barItems;
}


@end
