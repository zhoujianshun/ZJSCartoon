//
//  ZJSVLayoutModel.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/2/26.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZJSScalingListLayout.h"

#import "ZJSCollectionViewCellBaseViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZJSVLayoutModel : NSObject<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) ZJSScalingListLayout *vLayout;
@property (nonatomic, copy) NSArray<ZJSCollectionViewCellBaseViewModel*> *datas;
// 竖屏幕缩放
@property (nonatomic, strong) UIView *dummyZoomView;
@property (nonatomic, strong) UIScrollView *scrollView;

-(void)registerCell:(UICollectionView*)collectionView;
-(void)reloadData;

/**
 切换layout时调用，防止放大后造成的UI问题
 */
-(void)reset;

@end

NS_ASSUME_NONNULL_END
