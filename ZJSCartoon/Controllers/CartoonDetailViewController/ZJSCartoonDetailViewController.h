//
//  ZJSCartoonDetailViewController.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSBaseViewController.h"

#import "ZJSCartoonHomeCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSCartoonDetailViewController : ZJSBaseViewController


@property (nonatomic, strong) ZJSCartoonHomeCellViewModel *cartoonVM;

@end

NS_ASSUME_NONNULL_END
