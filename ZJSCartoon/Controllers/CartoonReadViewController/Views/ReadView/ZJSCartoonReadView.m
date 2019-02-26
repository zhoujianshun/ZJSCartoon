//
//  ZJSCartoonReadView.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/14.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonReadView.h"

#import <Masonry/Masonry.h>

#import <MJRefresh/MJRefresh.h>


#define kCellIdentify @"kTableIdentify"

@interface ZJSCartoonReadView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *vLayout;
@property (nonatomic, strong) UICollectionViewFlowLayout *hLayout;

@end

@implementation ZJSCartoonReadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
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
    self.pageStyle = ZJSCartoonReadPageStyleCol;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
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
  
    if ([self.delegate respondsToSelector:@selector(ZJSCartoonReadViewDidScroll:)]) {
        [self.delegate ZJSCartoonReadViewDidScroll:self];
    }
}

#pragma mark - private methods
-(void)loadNewData{
    if ([self.delegate respondsToSelector:@selector(ZJSCartoonReadViewRefresh:)]) {
        [self.delegate ZJSCartoonReadViewRefresh:self];
    }
}

#pragma mark - public methods
-(void)endRefresh{
    [self.collectionView.mj_header endRefreshing];
}

-(void)reloadData{
    [self.collectionView reloadData];
}

-(void)switchLayout{
    switch (self.pageStyle) {
        case ZJSCartoonReadPageStyleCol:
            {
                self.pageStyle = ZJSCartoonReadPageStyleRow;
                self.collectionView.pagingEnabled = YES;
               
            }
            break;
            
        default:
        {
            self.pageStyle = ZJSCartoonReadPageStyleCol;
            self.collectionView.pagingEnabled = NO;
            
        }
            break;
    }
}

#pragma mark - getters and setters
-(UICollectionView *)collectionView{
    if (!_collectionView) {

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.vLayout];
        [_collectionView registerClass:[ZJSCartoonReadCell class] forCellWithReuseIdentifier:kCellIdentify];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
       // _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)vLayout{
    if (!_vLayout) {
        _vLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _vLayout;
}

-(UICollectionViewFlowLayout *)hLayout{
    if (!_hLayout) {
        _hLayout = [[UICollectionViewFlowLayout alloc] init];
        _hLayout.scrollDirection= UICollectionViewScrollDirectionHorizontal;
    }
    return _hLayout;
}

-(void)setPageStyle:(ZJSCartoonReadPageStyle)pageStyle{
    _pageStyle = pageStyle;
    [self.datas enumerateObjectsUsingBlock:^(ZJSCollectionViewCellBaseViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZJSCartoonReadCellViewModel *vm = (ZJSCartoonReadCellViewModel *)obj;
        vm.pageStyle = self.pageStyle;
    }];
    
    typeof(self) weakself = self;
    switch (pageStyle) {
        case ZJSCartoonReadPageStyleCol:
        {
            [self.collectionView setCollectionViewLayout:self.vLayout animated:NO completion:^(BOOL finished) {
                [weakself.collectionView reloadData];
            }];
        }
            break;
            
        default:
        {
            [self.collectionView setCollectionViewLayout:self.hLayout animated:NO completion:^(BOOL finished) {
                [weakself.collectionView reloadData];
            }];
        }
            break;
    }
    
    
}

@end
