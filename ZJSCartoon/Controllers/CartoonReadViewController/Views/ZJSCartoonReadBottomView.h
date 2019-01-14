//
//  ZJSCartoonReadBottomView.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJSCartoonReadBottomView;

typedef void(^ZJSCartoonReadBottomViewActionBlock)(ZJSCartoonReadBottomView*);

NS_ASSUME_NONNULL_BEGIN

@interface ZJSCartoonReadBottomView : UIView

+(CGFloat)heightForView;
@property (nonatomic, copy) ZJSCartoonReadBottomViewActionBlock switchActionBlock;

@end

NS_ASSUME_NONNULL_END
