//
//  ZJSCarttonBaseRequest.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/14.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSBaseRequest.h"


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSCarttonBaseRequest : ZJSBaseRequest

@property (nonatomic, assign) BOOL hiddenLoading;
@property (nonatomic, assign) BOOL hiddenError;
@property (nonatomic, weak) UIView  *hudParentView;

@end

NS_ASSUME_NONNULL_END
