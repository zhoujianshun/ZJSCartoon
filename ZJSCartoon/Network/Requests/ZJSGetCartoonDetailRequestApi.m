//
//  ZJSGetCartoonDetailRequestApi.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSGetCartoonDetailRequestApi.h"

#import "NSString+ZJSUrlCode.h"

@implementation ZJSGetCartoonDetailRequestApi{
    NSString *_cartoonName;
}

-(instancetype)initWithCartoonName:(NSString*)cartoonName{
    self = [super init];
    if (self) {
        _cartoonName = cartoonName;
    }
    return self;
}

-(NSString *)requestUrl{
    return [[NSString stringWithFormat:@"/api/cartoon/%@", _cartoonName?:@""] URLEncodeString];
}

@end
