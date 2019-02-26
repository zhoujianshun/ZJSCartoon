//
//  UICollectionView+ZJSZoom.m
//  ZJSCollectionView_Test
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "UICollectionView+ZJSZoom.h"

CGSize ZJS_ZoomCGSizeScale(CGSize size,CGFloat scale){
    return CGSizeApplyAffineTransform(size, CGAffineTransformMakeScale(scale, scale));
}

CGRect ZJS_ZoomCGRectScale(CGRect rect,CGFloat scale){
   return CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(scale, scale));
}

@implementation UICollectionView (ZJSZoom)

-(NSArray<UICollectionViewCell*>*)getLingeringCells{
    CGRect visibleRect = CGRectMake(self.contentOffset.x, self.contentOffset.y, self.bounds.size.width, self.bounds.size.height);
    NSArray<UICollectionViewCell*> *visibleCells = self.visibleCells;
    
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UICollectionViewCell class]]&&
            CGRectIntersectsRect(visibleRect, obj.frame)&&
            (![visibleCells containsObject:obj])) {
            [mArray addObject:obj];
        }
    }];
    
    return [mArray copy];
}

-(void)hideLingeringCells{
    [[self getLingeringCells] enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
    }];
}

@end
