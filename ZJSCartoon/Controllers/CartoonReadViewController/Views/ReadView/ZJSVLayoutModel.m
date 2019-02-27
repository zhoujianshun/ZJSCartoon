//
//  ZJSVLayoutModel.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/2/26.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSVLayoutModel.h"

#import "ZJSCartoonVReadCell.h"

#import "ZJSScalingListLayout.h"
#import "ZJSScalingLayoutProtocol.h"
#import "UICollectionView+ZJSZoom.h"

#define kCellIdentify @"kVTableIdentify"

@interface ZJSVLayoutModel()<ZJSScalingListLayoutCustomDelegate>

@property (nonatomic, weak) UICollectionView  *collectionView;

@end

@implementation ZJSVLayoutModel

-(void)registerCell:(UICollectionView*)collectionView{
    [collectionView registerClass:[ZJSCartoonVReadCell class] forCellWithReuseIdentifier:kCellIdentify];
    self.collectionView = collectionView;
}

-(void)reloadData{
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.vLayout conformsToProtocol:@protocol(ZJSScalingLayoutProtocol)]){
            id<ZJSScalingLayoutProtocol> obj = (id<ZJSScalingLayoutProtocol>)self.vLayout;
            CGSize size = [obj contentSizeForScale:self.scrollView.zoomScale];
            self.scrollView.contentSize = size;
            self.dummyZoomView.frame = CGRectMake(0, 0, size.width, size.height);
        }
    });
}

#pragma mark - getters and setters

-(ZJSScalingListLayout *)vLayout{
    if (!_vLayout) {
//        _vLayout = [[UICollectionViewFlowLayout alloc] init];
        ZJSScalingListLayout *layout = [[ZJSScalingListLayout alloc] init];
        layout.delegate = self;
        _vLayout = layout;
        
    }
    return _vLayout;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.bouncesZoom = NO;
        _scrollView.alpha = 0.5;
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.zoomScale = 1.0;
        _scrollView.maximumZoomScale = 4.0;
        [_scrollView addSubview:self.dummyZoomView];
        
    }
    return _scrollView;
}

-(UIView *)dummyZoomView{
    if (!_dummyZoomView) {
        _dummyZoomView = [[UIView alloc] init];
    }
    return _dummyZoomView;
}



#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJSCartoonVReadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentify forIndexPath:indexPath];
    ZJSCartoonReadCellViewModel *vm = (ZJSCartoonReadCellViewModel*)[self.datas objectAtIndex:indexPath.item];
    cell.viewModel = vm;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJSCartoonReadCellViewModel *vm = (ZJSCartoonReadCellViewModel*)[self.datas objectAtIndex:indexPath.item];
    [vm cellTappedAction];
    
    //    ZJSCartoonDetailViewController *vc = [[ZJSCartoonDetailViewController alloc] init];
    //    vc.cartoonVM = vm;
    //    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.dummyZoomView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.collectionView.contentOffset = scrollView.contentOffset;
    [self.collectionView hideLingeringCells];
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    if([self.vLayout conformsToProtocol:@protocol(ZJSScalingLayoutProtocol)]){
        id<ZJSScalingLayoutProtocol> obj = (id<ZJSScalingLayoutProtocol>)self.vLayout;
        if ([obj scale] != self.scrollView.zoomScale) {
            [obj setScale:self.scrollView.zoomScale];
            [self.vLayout invalidateLayout];
            self.collectionView.contentOffset = self.scrollView.contentOffset;
            [self.collectionView hideLingeringCells];
        }
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.hidden = NO;
}

#pragma mark - UICollectionViewDelegateFlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    ZJSCartoonReadCellViewModel *vm = (ZJSCartoonReadCellViewModel *)[self.datas objectAtIndex:indexPath.item];
//
//    return vm.cellSize;
//}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return k_cartoon_chapter_minimumLineSpacing;
//}
//
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return k_cartoon_chapter_minimumInteritemSpacing;
//}
//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return k_cartoon_chapter_inset;
//}

#pragma mark - ZJSScalingListLayoutCustomDelegate

-(CGSize)zjs_zoomCollectionViewLayout:(ZJSScalingListLayout*)collectionViewLayout cellSizeAtIndexPath:(NSIndexPath*)indexPath{
    
    ZJSCartoonReadCellViewModel *vm = (ZJSCartoonReadCellViewModel *)[self.datas objectAtIndex:indexPath.item];
    
    return vm.cellSize;
}

-(CGFloat)zjs_zoomCollectionViewLayout:(ZJSScalingListLayout *)collectionViewLayout lineSpaceAtIndexPath:(NSIndexPath *)indexPath{
    return k_cartoon_chapter_minimumLineSpacing;
}

@end
