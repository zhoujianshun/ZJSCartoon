//
//  ZJSVLayoutModel.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/2/26.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ZJSCollectionViewCellBaseViewModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZJSVLayoutModel : NSObject<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *vLayout;
@property (nonatomic, copy) NSArray<ZJSCollectionViewCellBaseViewModel*> *datas;
// 竖屏幕缩放
@property (nonatomic, strong) UIView *dummyZoomView;
@property (nonatomic, strong) UIScrollView *scrollView;

-(void)registerCell:(UICollectionView*)collectionView;
-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
