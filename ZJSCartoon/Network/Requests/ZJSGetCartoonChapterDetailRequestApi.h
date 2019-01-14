//
//  ZJSGetCartoonChapterDetailRequestApi.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCarttonBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSGetCartoonChapterDetailRequestApi : ZJSCarttonBaseRequest

-(instancetype)initWithCartoonName:(NSString*)cartoonName chapter:(NSString*)chapter;

@end

NS_ASSUME_NONNULL_END
