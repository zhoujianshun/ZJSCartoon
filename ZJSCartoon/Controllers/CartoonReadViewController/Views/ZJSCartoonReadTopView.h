//
//  ZJSCartoonReadTopView.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJSCartoonReadTopView;

typedef void(^ZJSCartoonReadTopViewActionBlock)(ZJSCartoonReadTopView*);

NS_ASSUME_NONNULL_BEGIN

@interface ZJSCartoonReadTopView : UIView

@property (nonatomic, copy) ZJSCartoonReadTopViewActionBlock backActionBlock;

+(CGFloat)heightForStatusBarHidden:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
