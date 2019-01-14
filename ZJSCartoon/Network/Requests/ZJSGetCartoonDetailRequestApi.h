//
//  ZJSGetCartoonDetailRequestApi.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCarttonBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSGetCartoonDetailRequestApi : ZJSCarttonBaseRequest

-(instancetype)initWithCartoonName:(NSString*)cartoonName;

@end

NS_ASSUME_NONNULL_END
