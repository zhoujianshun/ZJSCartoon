//
//  ZJSZoomCollectionView.h
//  ZJSCollectionView_Test
//
//  Created by 周建顺 on 2019/1/9.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSZoomCollectionView : UIView

-(instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout*)layout;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat doubleTapScale;

@end

NS_ASSUME_NONNULL_END
