//
//  ZJSScalingGridLayout.h
//  ZJSCollectionView_Test
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZJSScalingLayoutProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSScalingGridLayout : UICollectionViewLayout<ZJSScalingLayoutProtocol>

-(instancetype)initWithItemSize:(CGSize)itemSize colums:(NSInteger)columns itemSpace:(CGFloat)itemSpacing scale:(CGFloat)scale;

//
//open let itemSize: CGSize
//open let columns: CGFloat
//open let itemSpacing: CGFloat

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) NSInteger columns;
@property (nonatomic, assign) CGFloat itemSpacing;

@end

NS_ASSUME_NONNULL_END
