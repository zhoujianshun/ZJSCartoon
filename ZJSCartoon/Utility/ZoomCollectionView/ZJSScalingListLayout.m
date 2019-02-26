//
//  ZJSScalingGridLayout.m
//  ZJSCollectionView_Test
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSScalingListLayout.h"

#import "UICollectionView+ZJSZoom.h"

@interface  ZJSScalingListLayout()
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*> *attributes;
@property (nonatomic, assign)  CGSize contentSize;

@end



@implementation ZJSScalingListLayout{

}

@synthesize scale = _scale;

-(instancetype)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    _scale = 1;
}



-(CGSize)collectionViewContentSize{
    return self.contentSize;
}

-(void)prepareLayout{
    [super prepareLayout];
    
    self.contentSize = [self contentSizeForScale:self.scale];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger columnCount = 1;
    NSMutableArray *mArray = [NSMutableArray array];
    
    id<ZJSScalingListLayoutCustomDelegate> obj;
    if ([self.delegate respondsToSelector:@selector(zjs_zoomCollectionViewLayout:cellSizeAtIndexPath:)]) {
        obj = (id<ZJSScalingListLayoutCustomDelegate>)self.delegate;
    }
    
    for (int i = 0; i < itemCount; i++) {
        NSInteger rowIdx = i/columnCount;
        NSInteger columnIdx = i%columnCount;
        
        CGSize itemSize = [obj zjs_zoomCollectionViewLayout:self cellSizeAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        CGFloat lineSpace = 0;
        if ([self.delegate respondsToSelector:@selector(zjs_zoomCollectionViewLayout:lineSpaceAtIndexPath:)]) {
            lineSpace = [self.delegate zjs_zoomCollectionViewLayout:self lineSpaceAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        }
        
        CGPoint point = CGPointMake((itemSize.width) * columnIdx, (itemSize.height + lineSpace) * rowIdx);
        CGRect rect = CGRectMake(point.x, point.y, itemSize.width, itemSize.height);
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]] ;
        attrs.frame = ZJS_ZoomCGRectScale(rect, self.scale);
        [mArray addObject:attrs];
    }
    
    self.attributes = mArray;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *mArray = [NSMutableArray array];
    [self.attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(obj.frame, rect)) {
            [mArray addObject:obj];
        }
    }];
    
    return mArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    __block UICollectionViewLayoutAttributes *attrs;
    [self.attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.indexPath == indexPath) {
            attrs = obj;
            *stop = YES;
        }
    }];
    
    return attrs;
}

#pragma mark -

-(void)setScale:(CGFloat)scale{
    _scale = scale;
}

-(CGFloat)scale{
    return _scale;
}

-(CGSize)contentSizeForScale:(CGFloat)scale{

    id<ZJSScalingListLayoutCustomDelegate> obj;
    if ([self.delegate respondsToSelector:@selector(zjs_zoomCollectionViewLayout:cellSizeAtIndexPath:)]) {
        obj = (id<ZJSScalingListLayoutCustomDelegate>)self.delegate;
    }
    
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger columnCount = 1;
    
    CGFloat width = 10;
    CGFloat height = 10;
    for (int i = 0; i < itemCount; i++) {
        NSInteger rowIdx = i/columnCount;
        NSInteger columnIdx = i%columnCount;
        
        CGSize itemSize = [obj zjs_zoomCollectionViewLayout:self cellSizeAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        CGFloat lineSpace = 0;
        if ([self.delegate respondsToSelector:@selector(zjs_zoomCollectionViewLayout:lineSpaceAtIndexPath:)]) {
            lineSpace = [self.delegate zjs_zoomCollectionViewLayout:self lineSpaceAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        }
        
        CGPoint point = CGPointMake((itemSize.width) * columnIdx, (itemSize.height + lineSpace) * rowIdx);
        CGRect rect = CGRectMake(point.x, point.y, itemSize.width, itemSize.height);
        width = itemSize.width;
        height = CGRectGetMaxY(rect);
    }
    
    return ZJS_ZoomCGSizeScale(CGSizeMake(width, height), scale);
}

@end
