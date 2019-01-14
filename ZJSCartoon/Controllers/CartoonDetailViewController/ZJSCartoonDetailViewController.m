//
//  ZJSCartoonDetailViewController.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonDetailViewController.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <BFKit/NSString+BFKit.h>
#import <MJRefresh/MJRefresh.h>

#import "ZJSGetCartoonDetailRequestApi.h"
#import "ZJSGetCartoonDetailReformer.h"

#import "ZJSCartoonDetailCell.h"

#import "ZJSCartoonReadViewController.h"


#define kCellIdentify @"kTableIdentify"

@interface ZJSCartoonDetailViewController ()<YTKRequestDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray<ZJSCollectionViewCellBaseViewModel*> *datas;

@end

@implementation ZJSCartoonDetailViewController



#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewContents];
    
    [self requestData];
}


-(void)setupViewContents{
    self.title = self.cartoonVM.name;
    
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
    ZJSCartoonDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentify forIndexPath:indexPath];
    ZJSCartoonDetailCellViewModel *vm = (ZJSCartoonDetailCellViewModel*)[self.datas objectAtIndex:indexPath.item];
    cell.viewModel = vm;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJSCartoonDetailCellViewModel *vm = (ZJSCartoonDetailCellViewModel*)[self.datas objectAtIndex:indexPath.item];
    [vm cellTappedAction];
    
    ZJSCartoonReadViewController *vc = [[ZJSCartoonReadViewController alloc] init];
    vc.carttonName = self.cartoonVM.name;
    vc.chapter = vm.chapterName;
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJSCollectionViewCellBaseViewModel *vm = [self.datas objectAtIndex:indexPath.item];
    return vm.cellSize;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return k_cartoon_detail_minimumLineSpacing;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return k_cartoon_detail_minimumInteritemSpacing;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return k_cartoon_detail_inset;
}




#pragma mark - YTKRequestDelegate


-(void)requestFinished:(__kindof YTKBaseRequest *)request{
    if ([request isKindOfClass:[ZJSGetCartoonDetailRequestApi class]]) {
        [self getCartoonDatailSuccess:(ZJSGetCartoonDetailRequestApi *)request];
    }
}

-(void)requestFailed:(__kindof YTKBaseRequest *)request{
    if ([request isKindOfClass:[ZJSGetCartoonDetailRequestApi class]]) {
        [self getCartoonDatailFail:(ZJSGetCartoonDetailRequestApi *)request];
    }
}

-(void)getCartoonDatailSuccess:(ZJSGetCartoonDetailRequestApi*)api{
    [self.collectionView.mj_header endRefreshing];
    NSDictionary *result = [api fetchDataWithReformer:[[ZJSGetCartoonDetailReformer alloc] init]];
    self.datas = result[ZJSGetCartoonDatailReformerResultKey];
    [self.collectionView reloadData];
}

-(void)getCartoonDatailFail:(ZJSGetCartoonDetailRequestApi*)api{
    [self.collectionView.mj_header endRefreshing];
}


#pragma mark - event response

-(void)loadNewData{
    [self requestData];
}

#pragma mark - private methods

-(void)requestData{
    ZJSGetCartoonDetailRequestApi *api = [[ZJSGetCartoonDetailRequestApi alloc] initWithCartoonName:self.cartoonVM.name];
    api.delegate = self;
    api.hudParentView = self.view;
    [api start];
}

#pragma mark - getters and setters
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[ZJSCartoonDetailCell class] forCellWithReuseIdentifier:kCellIdentify];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    }
    return _collectionView;
}



@end
