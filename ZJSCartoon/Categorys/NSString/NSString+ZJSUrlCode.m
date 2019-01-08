//
//  NSString+ZJSUrlCode.m
//  ZJSDemos
//
//  Created by 周建顺 on 2018/9/5.
//  Copyright © 2018年 周建顺. All rights reserved.
//

#import "NSString+ZJSUrlCode.h"

@implementation NSString (ZJSUrlCode)

- (NSString *)URLEncodeString{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8));
#pragma clang diagnostic pop
}

- (NSString *)URLDecodeString{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSString *encodedString = self;
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)encodedString, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)); return decodedString;
    return decodedString;
#pragma clang diagnostic pop
}



@end
