//
//  ASTableViewGroupModel.h
//  RippleSENS8
//
//  Created by 周建顺 on 2018/6/21.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ZJSTableViewCellBaseViewModel.h"
#import "ZJSTableViewHeaderBaseViewModel.h"
#import "ZJSTableViewFooterBaseViewModel.h"

@interface ZJSTableViewGroupBaseModel : NSObject

@property (nonatomic, strong) ZJSTableViewHeaderBaseViewModel *headerViewModel;
@property (nonatomic, strong) ZJSTableViewFooterBaseViewModel *footerViewModel;
@property (nonatomic, strong) NSMutableArray<ZJSTableViewCellBaseViewModel*> *datas;

@property (nonatomic) CGFloat headerHeight;
@property (nonatomic) CGFloat footerHeight;

-(CGFloat)footerHeight;
-(CGFloat)headerHeight;
@end
