//
//  UICollectionView+ZJSZoom.h
//  ZJSCollectionView_Test
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>

CGSize ZJS_ZoomCGSizeScale(CGSize size,CGFloat scale);

CGRect ZJS_ZoomCGRectScale(CGRect rect,CGFloat scale);

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (ZJSZoom)

-(NSArray<UICollectionViewCell*>*)getLingeringCells;

-(void)hideLingeringCells;

@end

NS_ASSUME_NONNULL_END
