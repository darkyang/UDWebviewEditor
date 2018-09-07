//
//  UDArticleModel.h
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/7.
//  Copyright © 2018年 UD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UDArticleModel : NSObject

@property (nonatomic, copy, readwrite) NSString* title;
@property (nonatomic, copy, readwrite) NSString* content;

@property (nonatomic, strong, readwrite) NSMutableSet *imageIDSet;

@end
