//
//  NSString+UDExtension.h
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/8.
//  Copyright © 2018年 UD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UDExtension)

/*!
 * @brief string - strip whitespace & newline at start and end
 */
- (NSString*)trimmedString;

/*!
 *  @brief string - trimmed whitespace & newline full length
 */
- (NSString*)trimmedAllString;

@end
