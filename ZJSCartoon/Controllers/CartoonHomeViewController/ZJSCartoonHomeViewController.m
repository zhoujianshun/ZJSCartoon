//
//  ZJSCartoonHomeViewController.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonHomeViewController.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <BFKit/NSString+BFKit.h>
#import <MJRefresh/MJRefresh.h>

#import "ZJSGetAllCartoonsRequestApi.h"
#import "ZJSGetAllCartoonsHomeReformer.h"

#import "ZJSCartoonHomeCollectionViewCell.h"

#import "ZJSCartoonDetailViewController.h"
#import "ZJSCartoonSettingsViewController.h"
#import "ZJSBaseNavigationController.h"

#define kCellIdentify @"kTableIdentify"


@interface ZJSCartoonHomeViewController ()<YTKRequestDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray<ZJSCollectionViewCellBaseViewModel*> *datas;

@end

@implementation ZJSCartoonHomeViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewContents];
    
    [self requestData];
}


-(void)setupViewContents{
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"Settings" forState:UIControlStateNormal];
    [rightButton sizeToFit];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
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
    ZJSCartoonHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentify forIndexPath:indexPath];
    ZJSCartoonHomeCellViewModel *vm = (ZJSCartoonHomeCellViewModel*)[self.datas objectAtIndex:indexPath.item];
    cell.viewModel = vm;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZJSCartoonHomeCellViewModel *vm = (ZJSCartoonHomeCellViewModel*)[self.datas objectAtIndex:indexPath.item];
    [vm cellTappedAction];
    
    ZJSCartoonDetailViewController *vc = [[ZJSCartoonDetailViewController alloc] init];
    vc.cartoonVM = vm;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJSCollectionViewCellBaseViewModel *vm = [self.datas objectAtIndex:indexPath.item];
    return vm.cellSize;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return k_cartoon_home_minimumLineSpacing;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return k_cartoon_home_minimumInteritemSpacing;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return k_cartoon_home_inset;
}




#pragma mark - YTKRequestDelegate


-(void)requestFinished:(__kindof YTKBaseRequest *)request{
    if ([request isKindOfClass:[ZJSGetAllCartoonsRequestApi class]]) {
        [self getAllCartoonsSuccess:(ZJSGetAllCartoonsRequestApi *)request];
    }
}

-(void)requestFailed:(__kindof YTKBaseRequest *)request{
    if ([request isKindOfClass:[ZJSGetAllCartoonsRequestApi class]]) {
        [self getAllCartoonsFail:(ZJSGetAllCartoonsRequestApi *)request];
    }
}

-(void)getAllCartoonsSuccess:(ZJSGetAllCartoonsRequestApi*)api{
    [self.collectionView.mj_header endRefreshing];
    NSDictionary *result = [api fetchDataWithReformer:[[ZJSGetAllCartoonsHomeReformer alloc] init]];
    self.datas = result[ZJSGetAllCartoonsHomeReformerResultKey];
    [self.collectionView reloadData];
}

-(void)getAllCartoonsFail:(ZJSGetAllCartoonsRequestApi*)api{
    [self.collectionView.mj_header endRefreshing];
}


#pragma mark - event response

-(void)loadNewData{
    [self requestData];
}

-(void)rightButtonAction:(UIButton*)sender{
    ZJSCartoonSettingsViewController *rootVC = [[ZJSCartoonSettingsViewController alloc] init];
    ZJSBaseNavigationController *navi = [[ZJSBaseNavigationController alloc] initWithRootViewController:rootVC];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma mark - private methods

-(void)requestData{
    ZJSGetAllCartoonsRequestApi *api = [[ZJSGetAllCartoonsRequestApi alloc] init];
    api.delegate = self;
    api.hudParentView = self.view;
    [api start];
}

#pragma mark - getters and setters
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[ZJSCartoonHomeCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentify];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    }
    return _collectionView;
}


@end
