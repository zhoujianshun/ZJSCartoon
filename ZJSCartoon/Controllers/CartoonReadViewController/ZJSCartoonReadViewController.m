//
//  ZJSCartoonReadViewController.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonReadViewController.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <BFKit/NSString+BFKit.h>
#import <BFKit/UIScreen+BFKit.h>

#import "ZJSGetCartoonChapterDetailRequestApi.h"
#import "ZJSGetCartoonChapterDetailReformer.h"

#import "ZJSCartoonReadCell.h"

#import "ZJSCartoonRead.h"

#define kCellIdentify @"kTableIdentify"

const CGFloat kScaleBoundLower = 0.5;
const CGFloat kScaleBoundUpper = 2.0;

@interface ZJSCartoonReadViewController ()<YTKRequestDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray<ZJSCollectionViewCellBaseViewModel*> *datas;
@property (nonatomic, assign) ZJSCartoonReadPageStyle pageStyle;

@end

@implementation ZJSCartoonReadViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupViewContents];
    
    [self requestData];
}


-(void)setupViewContents{
    self.title = self.carttonName;
    self.pageStyle = ZJSCartoonReadPageStyleCol;
    self.collectionView.maximumZoomScale = 2;
    self.collectionView.minimumZoomScale = 0.5;
    self.collectionView.zoomScale = 0.5;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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


#pragma mark - YTKRequestDelegate


-(void)requestFinished:(__kindof YTKBaseRequest *)request{
    if ([request isKindOfClass:[ZJSGetCartoonChapterDetailRequestApi class]]) {
        [self getCartoonChapterDatailSuccess:(ZJSGetCartoonChapterDetailRequestApi *)request];
    }
}

-(void)requestFailed:(__kindof YTKBaseRequest *)request{
    if ([request isKindOfClass:[ZJSGetCartoonChapterDetailRequestApi class]]) {
        [self getCartoonChapterDatailFail:(ZJSGetCartoonChapterDetailRequestApi *)request];
    }
}

-(void)getCartoonChapterDatailSuccess:(ZJSGetCartoonChapterDetailRequestApi*)api{
    
    ZJSGetCartoonChapterDetailReformer *reformer = [[ZJSGetCartoonChapterDetailReformer alloc] init];
    reformer.pageStyle = self.pageStyle;
    NSDictionary *result = [api fetchDataWithReformer:reformer];
    self.datas = result[ZJSGetCartoonChapterReformerResultKey];
    [self.collectionView reloadData];
}

-(void)getCartoonChapterDatailFail:(ZJSGetCartoonChapterDetailRequestApi*)api{
    
}


#pragma mark - event response

#pragma mark - private methods

-(void)requestData{
    ZJSGetCartoonChapterDetailRequestApi *api = [[ZJSGetCartoonChapterDetailRequestApi alloc] initWithCartoonName:self.carttonName chapter:self.chapter];
    api.delegate = self;
    [api start];
}

#pragma mark - getters and setters
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[ZJSCartoonReadCell class] forCellWithReuseIdentifier:kCellIdentify];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

-(void)setPageStyle:(ZJSCartoonReadPageStyle)pageStyle{
    _pageStyle = pageStyle;
    [self.datas enumerateObjectsUsingBlock:^(ZJSCollectionViewCellBaseViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZJSCartoonReadCellViewModel *vm = (ZJSCartoonReadCellViewModel *)obj;
        vm.pageStyle = self.pageStyle;
    }];
}

@end
