//
//  ZJSScalingGridLayout.h
//  ZJSCollectionView_Test
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZJSScalingLayoutProtocol.h"

@class ZJSScalingListLayout;

NS_ASSUME_NONNULL_BEGIN

@protocol ZJSScalingListLayoutCustomDelegate <NSObject>

-(CGSize)zjs_zoomCollectionViewLayout:(ZJSScalingListLayout*)collectionViewLayout cellSizeAtIndexPath:(NSIndexPath*)indexPath;
-(CGFloat)zjs_zoomCollectionViewLayout:(ZJSScalingListLayout*)collectionViewLayout lineSpaceAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface ZJSScalingListLayout : UICollectionViewLayout<ZJSScalingLayoutProtocol>

@property (nonatomic, weak) id<ZJSScalingListLayoutCustomDelegate> delegate;

@end



NS_ASSUME_NONNULL_END
