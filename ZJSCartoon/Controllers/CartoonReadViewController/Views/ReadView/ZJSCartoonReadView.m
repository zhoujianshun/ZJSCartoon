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

#import "ZJSHLayoutModel.h"
#import "ZJSVLayoutModel.h"

#import "ZJSCartoonReadCellViewModel.h"



#define kCellIdentify @"kTableIdentify"

@interface ZJSCartoonReadView ()


@property (nonatomic, strong) ZJSHLayoutModel *hLayoutModel;
@property (nonatomic, strong) ZJSVLayoutModel *vLayoutModel;



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
    
    [self addSubview:self.vLayoutModel.scrollView];

    [self.vLayoutModel.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.collectionView);
    }];
    
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
    self.vLayoutModel.datas = self.datas;
    self.hLayoutModel.datas = self.datas;
    [self.collectionView reloadData];
    
    [self.vLayoutModel reloadData];
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

-(ZJSVLayoutModel *)vLayoutModel{
    if (!_vLayoutModel) {
        _vLayoutModel = [[ZJSVLayoutModel alloc] init];
    }
    return _vLayoutModel;
}

-(ZJSHLayoutModel *)hLayoutModel{
    if (!_hLayoutModel) {
        _hLayoutModel = [[ZJSHLayoutModel alloc] init];
    }
    return _hLayoutModel;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.vLayoutModel.vLayout];
        [self.vLayoutModel registerCell:_collectionView];
        [self.hLayoutModel registerCell:_collectionView];
        _collectionView.delegate = self.vLayoutModel;
        _collectionView.dataSource = self.vLayoutModel;
        _collectionView.backgroundColor = [UIColor clearColor];
       // _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
    }
    return _collectionView;
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
            NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
            self.vLayoutModel.scrollView.hidden = NO;
            self.collectionView.delegate = self.vLayoutModel;
            self.collectionView.dataSource = self.vLayoutModel;
            [self.collectionView setCollectionViewLayout:self.vLayoutModel.vLayout animated:NO completion:^(BOOL finished) {
                [weakself.collectionView reloadData];
                [weakself.vLayoutModel reloadData];
                if (indexPath) {
                    [weakself.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionTop];
                }
            }];
           
        }
            break;
            
        default:
        {
         //   self.vLayoutModel.scrollView.zoomScale = 1.f;
            
            
            NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
            self.vLayoutModel.scrollView.hidden = YES;
            self.collectionView.delegate = self.hLayoutModel;
            self.collectionView.dataSource = self.hLayoutModel;
            [self.collectionView setCollectionViewLayout:self.hLayoutModel.hLayout animated:NO completion:^(BOOL finished) {
                [weakself.collectionView reloadData];
             
                if (indexPath) {
                    [weakself.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
                }

            }];
        }
            break;
    }
    
    
}

@end
