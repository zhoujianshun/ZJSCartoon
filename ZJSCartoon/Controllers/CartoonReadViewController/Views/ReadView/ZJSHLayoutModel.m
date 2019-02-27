//
//  ZJSHLayoutModel.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/2/26.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSHLayoutModel.h"

#import "ZJSCartoonReadCell.h"

#define kCellIdentify @"kTableIdentify"

@interface ZJSHLayoutModel()

@end

@implementation ZJSHLayoutModel

-(void)registerCell:(UICollectionView*)collectionView{
    [collectionView registerClass:[ZJSCartoonReadCell class] forCellWithReuseIdentifier:kCellIdentify];
}

#pragma mark - getters and setters

-(UICollectionViewFlowLayout *)hLayout{
    if (!_hLayout) {
        _hLayout = [[UICollectionViewFlowLayout alloc] init];
        _hLayout.scrollDirection= UICollectionViewScrollDirectionHorizontal;
    }
    return _hLayout;
}


#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJSCartoonReadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentify forIndexPath:indexPath];
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

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJSCartoonReadCellViewModel *vm = (ZJSCartoonReadCellViewModel *)[self.datas objectAtIndex:indexPath.item];
    
    return vm.cellSize;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return k_cartoon_chapter_minimumLineSpacing;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return k_cartoon_chapter_minimumInteritemSpacing;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return k_cartoon_chapter_inset;
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    if ([self.delegate respondsToSelector:@selector(ZJSCartoonReadViewDidScroll:)]) {
//        [self.delegate ZJSCartoonReadViewDidScroll:self];
//    }
}

@end
