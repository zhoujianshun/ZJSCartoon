//
//  ASCollectionViewBaseViewModel.h
//  RippleSENS8
//
//  Created by 周建顺 on 2018/7/20.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZJSCollectionViewCellBaseViewModel;

typedef void(^ASCollectionViewBaseViewModelCellTappedBlock)(ZJSCollectionViewCellBaseViewModel *sender);

@interface ZJSCollectionViewCellBaseViewModel : NSObject

@property (nonatomic) CGSize cellSize;
//@property (nonatomic) CGFloat cellHeigh;
@property (nonatomic, copy) ASCollectionViewBaseViewModelCellTappedBlock cellTappedActionBlock;

@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic) BOOL lineHidden;

/**
 预留的值，用户可以用来保存需要的值
 */
@property (nonatomic, strong) id userValue;

-(CGSize)cellSize;

-(void)cellTappedAction;

@end
