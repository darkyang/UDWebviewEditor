//
//  BKEditorFormatbarView.h
//  EditorDemo
//
//  Created by mac_work_zhao on 2018/3/15.
//  Copyright © 2018年 Automattic, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZSSBarButtonItem;
@class BKEditorFormatbarView;

extern const CGFloat WPEditorFormatbarViewToolbarHeight;

typedef NS_OPTIONS(NSInteger, BKEditorViewControllerElementTag){
    kBKEditorViewControllerElementTagUnknown = -1,
    kBKEditorViewControllerElementTagFoldKeyboard,
    kBKEditorViewControllerElementTagInsertImage,
    kBKEditorViewControllerElementTagAtPerson,
    kBKEditorViewControllerElementTagInsertTag
};

@protocol BKEditorFormatbarViewDelegate <NSObject>

@required

- (void)editorToolbarView:(BKEditorFormatbarView*)editorToolbarView changeKeyboard:(UIBarButtonItem*)barButtonItem;

- (void)editorToolbarView:(BKEditorFormatbarView*)editorToolbarView insertImage:(UIBarButtonItem*)barButtonItem;

- (void)editorToolbarView:(BKEditorFormatbarView*)editorToolbarView atUser:(UIBarButtonItem*)barButtonItem;

- (void)editorToolbarView:(BKEditorFormatbarView*)editorToolbarView addTag:(UIBarButtonItem*)barButtonItem;

@end

@interface BKEditorFormatbarView : UIView

@property (nonatomic, weak, readwrite) id<BKEditorFormatbarViewDelegate> delegate;

@property (nonatomic, copy, readwrite) UIColor *borderColor;

@property (nonatomic, strong) UIColor *itemTintColor;

@property (nonatomic, strong) UIColor *itemUnableTintColor;

@property (nonatomic, strong) UIColor *itemSelectedTintColor;

- (UIBarButtonItem*)toolbarItemWithTag:(BKEditorViewControllerElementTag)tag;

- (void)toolbarItemWithTag:(BKEditorViewControllerElementTag)tag setVisible:(BOOL)visible;

- (void)toolbarItemWithTag:(BKEditorViewControllerElementTag)tag setSelected:(BOOL)selected;

- (void)toggleSelectionForToolbarItemWithTag:(BKEditorViewControllerElementTag)tag;

- (void)enableToolbarItems:(BOOL)enable;

- (void)clearSelectedToolbarItems;

- (void)selectToolbarItemsForStyles:(NSArray*)styles;

@end
