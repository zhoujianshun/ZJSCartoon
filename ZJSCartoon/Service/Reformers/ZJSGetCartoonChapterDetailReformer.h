//
//  ZJSGetCartoonChapterDetailReformer.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZJSGetCartoonChapterDetailRequestApi.h"

#import "ZJSCartoonRead.h"


extern NSString *const ZJSGetCartoonChapterReformerResultKey;

NS_ASSUME_NONNULL_BEGIN

@interface ZJSGetCartoonChapterDetailReformer : NSObject<ZJSReformerProtocol>

@property (nonatomic, assign) ZJSCartoonReadPageStyle pageStyle;

@end

NS_ASSUME_NONNULL_END
