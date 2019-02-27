//
//  ZJSHLayoutModel.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/2/26.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ZJSCollectionViewCellBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSHLayoutModel : NSObject<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *hLayout;
@property (nonatomic, copy) NSArray<ZJSCollectionViewCellBaseViewModel*> *datas;

-(void)registerCell:(UICollectionView*)collectionView;

@end

NS_ASSUME_NONNULL_END
