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


#import "ZJSScreenUtility.h"

#import "ZJSGetCartoonChapterDetailRequestApi.h"
#import "ZJSGetCartoonChapterDetailReformer.h"


#import "ZJSCartoonReadTopView.h"
#import "ZJSCartoonReadBottomView.h"
#import "ZJSCartoonReadView.h"





@interface ZJSCartoonReadViewController ()<YTKRequestDelegate, ZJSCartoonReadViewDelegate>

@property (nonatomic, strong) ZJSCartoonReadView *readView;
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
    
   
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenTap:)];
    [self.view addGestureRecognizer:tap];

    [self layoutViewContents];
}

-(void)layoutViewContents{
    [self.view addSubview:self.readView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    
    [self.readView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [self.readView endRefresh];
    ZJSGetCartoonChapterDetailReformer *reformer = [[ZJSGetCartoonChapterDetailReformer alloc] init];
    reformer.pageStyle = self.readView.pageStyle;
    NSDictionary *result = [api fetchDataWithReformer:reformer];
    self.readView.datas = result[ZJSGetCartoonChapterReformerResultKey];
    [self.readView reloadData];
}

-(void)getCartoonChapterDatailFail:(ZJSGetCartoonChapterDetailRequestApi*)api{
    [self.readView endRefresh];
}

#pragma mark - ZJSCartoonReadViewDelegate
-(void)ZJSCartoonReadViewDidScroll:(ZJSCartoonReadView *)cartoonReadView{
    self.fullScreen = YES;
}

-(void)ZJSCartoonReadViewRefresh:(ZJSCartoonReadView *)cartoonReadView{
     [self requestData];
}

#pragma mark - event response

-(void)backAction{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)screenTap:(UITapGestureRecognizer*)sender{
    self.fullScreen = !self.fullScreen;
}

-(void)switchLayout{
    [self.readView switchLayout];
}


#pragma mark - private methods

-(void)requestData{
    ZJSGetCartoonChapterDetailRequestApi *api = [[ZJSGetCartoonChapterDetailRequestApi alloc] initWithCartoonName:self.carttonName chapter:self.chapter];
    api.delegate = self;
    api.hudParentView = self.view;
    [api start];
}


#pragma mark - getters and setters

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
        typeof(self) weakself = self;
        _bottomView.switchActionBlock = ^(ZJSCartoonReadBottomView * sender) {
            [weakself switchLayout];
        };
    }
    return _bottomView;
}

-(ZJSCartoonReadView *)readView{
    if (!_readView) {
        _readView = [[ZJSCartoonReadView alloc] init];
        _readView.delegate = self;
    }
    return _readView;
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
