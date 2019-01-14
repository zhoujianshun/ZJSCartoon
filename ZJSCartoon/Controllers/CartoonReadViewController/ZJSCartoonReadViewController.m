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
#import <MJRefresh/MJRefresh.h>

#import "ZJSScreenUtility.h"

#import "ZJSGetCartoonChapterDetailRequestApi.h"
#import "ZJSGetCartoonChapterDetailReformer.h"

#import "ZJSCartoonReadCell.h"
#import "ZJSCartoonReadTopView.h"
#import "ZJSCartoonReadBottomView.h"

#import "ZJSCartoonRead.h"

#define kCellIdentify @"kTableIdentify"

const CGFloat kScaleBoundLower = 0.5;
const CGFloat kScaleBoundUpper = 2.0;

@interface ZJSCartoonReadViewController ()<YTKRequestDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray<ZJSCollectionViewCellBaseViewModel*> *datas;
@property (nonatomic, assign) ZJSCartoonReadPageStyle pageStyle;


@property (nonatomic, strong) ZJSCartoonReadTopView *topView;
@property (nonatomic, strong) ZJSCartoonReadBottomView *bottomView;
@property (nonatomic) BOOL fullScreen;

@end

@implementation ZJSCartoonReadViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupViewContents];
    
    [self requestData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(BOOL)prefersStatusBarHidden{
    if ([ZJSScreenUtility isiPhoneXScreen]) {
        return NO;
    }
    return YES;
}

-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}

-(UIRectEdge)preferredScreenEdgesDeferringSystemGestures{
    return UIRectEdgeAll;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)setupViewContents{
    

    self.view.backgroundColor = [UIColor grayColor];
    self.title = self.carttonName;
    self.pageStyle = ZJSCartoonReadPageStyleCol;
   
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTap:)];
    [self.view addGestureRecognizer:tap];

    [self layoutViewContents];
}

-(void)layoutViewContents{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.superview);
        make.leading.equalTo(self.topView.superview);
        make.trailing.equalTo(self.topView.superview);
        make.height.equalTo(@([ZJSCartoonReadTopView heightForStatusBarHidden:![ZJSScreenUtility isiPhoneXScreen]]));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.superview);
        make.leading.equalTo(self.bottomView.superview);
        make.trailing.equalTo(self.bottomView.superview);
        make.height.equalTo(@([ZJSCartoonReadBottomView heightForView]));
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
    self.fullScreen = YES;
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
    [self.collectionView.mj_header endRefreshing];
    ZJSGetCartoonChapterDetailReformer *reformer = [[ZJSGetCartoonChapterDetailReformer alloc] init];
    reformer.pageStyle = self.pageStyle;
    NSDictionary *result = [api fetchDataWithReformer:reformer];
    self.datas = result[ZJSGetCartoonChapterReformerResultKey];
    [self.collectionView reloadData];
}

-(void)getCartoonChapterDatailFail:(ZJSGetCartoonChapterDetailRequestApi*)api{
    [self.collectionView.mj_header endRefreshing];
}


#pragma mark - event response

-(void)backAction{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)screenTap:(UITapGestureRecognizer*)sender{
    self.fullScreen = !self.fullScreen;
}

-(void)loadNewData{
    [self requestData];
}


#pragma mark - private methods

-(void)requestData{
    ZJSGetCartoonChapterDetailRequestApi *api = [[ZJSGetCartoonChapterDetailRequestApi alloc] initWithCartoonName:self.carttonName chapter:self.chapter];
    api.delegate = self;
    api.hudParentView = self.view;
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
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    }
    return _collectionView;
}

-(ZJSCartoonReadTopView *)topView{
    if (!_topView) {
        _topView = [[ZJSCartoonReadTopView alloc] init];
        typeof(self) weakself = self;
        _topView.backActionBlock = ^(ZJSCartoonReadTopView *sender) {
            [weakself backAction];
        };
    }
    return _topView;
}

-(ZJSCartoonReadBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[ZJSCartoonReadBottomView alloc] init];
    }
    return _bottomView;
}

-(void)setPageStyle:(ZJSCartoonReadPageStyle)pageStyle{
    _pageStyle = pageStyle;
    [self.datas enumerateObjectsUsingBlock:^(ZJSCollectionViewCellBaseViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZJSCartoonReadCellViewModel *vm = (ZJSCartoonReadCellViewModel *)obj;
        vm.pageStyle = self.pageStyle;
    }];
}

-(void)setFullScreen:(BOOL)fullScreen{
 
    
    if (_fullScreen != fullScreen) {
        _fullScreen = fullScreen;
        if (_fullScreen) {
            
            CGFloat offset =  -[ZJSCartoonReadTopView heightForStatusBarHidden:![ZJSScreenUtility isiPhoneXScreen]];
            [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.topView.superview.mas_top).offset(offset);
            }];
            
            CGFloat bottomOffset =  [ZJSCartoonReadBottomView heightForView];
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.topView.superview.mas_bottom).offset(bottomOffset);
            }];
        }else{
            [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.topView.superview.mas_top);
            }];
            
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.topView.superview.mas_bottom);
            }];
        }
        
        [UIView animateWithDuration:0.2f animations:^{
            [self.view layoutIfNeeded];
        }];
    }
   
}


@end
