//
//  ZJSGetCartoonChapterDetailRequestApi.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSGetCartoonChapterDetailRequestApi.h"

#import "NSString+ZJSUrlCode.h"

@implementation ZJSGetCartoonChapterDetailRequestApi{
    NSString *_cartoonName;
    NSString *_chapter;
}

-(instancetype)initWithCartoonName:(NSString*)cartoonName chapter:(NSString*)chapter{
    self = [super init];
    if (self) {
        _cartoonName = cartoonName;
        _chapter = chapter;
    }
    return self;
}

-(NSString *)requestUrl{
    return [[NSString stringWithFormat:@"/api/cartoon/%@/%@", _cartoonName, _chapter] URLEncodeString];
}

@end
