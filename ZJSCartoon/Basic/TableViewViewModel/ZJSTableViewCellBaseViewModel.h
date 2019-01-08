//
//  ASTableViewCellBaseViewModel.h
//  RippleSENS8
//
//  Created by 周建顺 on 2018/6/21.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZJSTableViewCellBaseViewModel;

typedef void(^ZJSTableViewCellTappedActionBlock)(ZJSTableViewCellBaseViewModel *sender);

@interface ZJSTableViewCellBaseViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) ZJSTableViewCellTappedActionBlock cellTappedActionBlock;
/**
 预留的值，用户可以用来保存需要的值
 */
@property (nonatomic, strong) id userValue;

@property (nonatomic) CGFloat cellHeight;

-(CGFloat)cellHeight;


-(void)cellTappedAction;

@end
