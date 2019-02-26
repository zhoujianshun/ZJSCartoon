//
//  ZJSScalingGridLayout.m
//  ZJSCollectionView_Test
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSScalingGridLayout.h"

#import "UICollectionView+ZJSZoom.h"

@interface  ZJSScalingGridLayout()
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*> *attributes;
@property (nonatomic, assign)  CGSize contentSize;

@end



@implementation ZJSScalingGridLayout{

}

@synthesize scale = _scale;

-(instancetype)initWithItemSize:(CGSize)itemSize colums:(NSInteger)columns itemSpace:(CGFloat)itemSpacing scale:(CGFloat)scale{
    self = [super init];
    if (self) {
        _itemSize = itemSize;
        _columns = columns;
        _itemSpacing = itemSpacing;
        _scale = scale;
    }
    return self;
}


-(CGSize)collectionViewContentSize{
    return self.contentSize;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

-(void)prepareLayout{
    [super prepareLayout];
    
//    self.contentSize = contentSizeForScale(self.scale)
//    let itemCount = self.collectionView!.numberOfItems(inSection: 0)
//    let columnCount = self.columns
//
//    attributes = (0..<itemCount).map { idx in
//        let rowIdx = floor(Double(idx) / Double(columnCount))
//        let columnIdx =  idx % Int(columnCount)
//        let pt = CGPoint(
//                         x: (itemSize.width + itemSpacing) * CGFloat(columnIdx),
//                         y: (itemSize.height + itemSpacing) * CGFloat(rowIdx)
//                         )
//        let rect = CGRect(origin: pt, size: self.itemSize)
//        let attr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: idx, section: 0))
//        attr.frame = rect.scale(self.scale)
//        return attr
//    }
    
    self.contentSize = [self contentSizeForScale:self.scale];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger columnCount = self.columns;
    NSMutableArray *mArray = [NSMutableArray array];
    
    for (int i = 0; i < itemCount; i++) {
        NSInteger rowIdx = i/columnCount;
        NSInteger columnIdx = i%columnCount;
        CGPoint point = CGPointMake((self.itemSize.width + self.itemSpacing) * columnIdx, (self.itemSize.height + self.itemSpacing) * rowIdx);
        CGRect rect = CGRectMake(point.x, point.y, self.itemSize.width, self.itemSize.height);
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
//    let itemCount = collectionView!.numberOfItems(inSection: 0)
//    let rowCount = ceil(CGFloat(itemCount)/CGFloat(columns))
//    let sz = CGSize(
//                    width: itemSize.width * columns + itemSpacing * (columns - 1),
//                    height: itemSize.height * rowCount + itemSpacing * (rowCount - 1)
//                    )
//    return sz.scale(scale)
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    double rowCount = ceil(((CGFloat)itemCount)/((CGFloat)self.columns));
    CGSize size = CGSizeMake(self.itemSize.width * self.columns + self.itemSpacing * (self.columns - 1), self.itemSize.height * rowCount + self.itemSpacing * (rowCount - 1));
    
    return ZJS_ZoomCGSizeScale(size, self.scale);
}

@end
