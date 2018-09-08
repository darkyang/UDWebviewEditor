//
//  NSString+UDExtension.m
//  UDWebViewEditor
//
//  Created by 赵琨 on 2018/9/8.
//  Copyright © 2018年 UD. All rights reserved.
//

#import "NSString+UDExtension.h"

@implementation NSString (UDExtension)

- (NSString*)trimmedString{
    NSString* temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)trimmedAllString{
    NSString *tmp = [self stringByReplacingOccurrencesOfString:@" " withString:NullString];
    tmp = [tmp stringByReplacingOccurrencesOfString:@"\r" withString:NullString];
    tmp = [tmp stringByReplacingOccurrencesOfString:@"\n" withString:NullString];
    return tmp;
}

@end
