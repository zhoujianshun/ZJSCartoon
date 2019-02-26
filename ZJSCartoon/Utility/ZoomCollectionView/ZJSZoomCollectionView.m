//
//  ZJSZoomCollectionView.m
//  ZJSCollectionView_Test
//
//  Created by 周建顺 on 2019/1/9.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSZoomCollectionView.h"

#import "ZJSScalingLayoutProtocol.h"
#import "UICollectionView+ZJSZoom.h"


@interface ZJSZoomCollectionView()<UIScrollViewDelegate, UICollectionViewDelegate>



@property (nonatomic, strong) UIView *dummyZoomView;
@property (nonatomic, strong) UICollectionViewLayout *layout;

@end

@implementation ZJSZoomCollectionView

-(instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewLayout*)layout{
    self = [super initWithFrame:frame];
    if (self) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.layout = layout;
        
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    self.doubleTapScale = 2;
//    [self.collectionView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.collectionView removeGestureRecognizer:obj];
//    }];
    self.collectionView.delegate = self;
    self.collectionView.frame = self.bounds;
    self.scrollView.frame = self.bounds;
    [self addSubview:self.collectionView];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.dummyZoomView];
    
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];
}


-(void)doubleTapped:(UITapGestureRecognizer *)sender{
//    if (self.scrollView.zoomScale != 1) {
//
//        [UIView animateWithDuration:0.5 animations:^{
////            self.collectionView.contentSize = CGSizeApplyAffineTransform(self.collectionView.contentSize, CGAffineTransformMakeScale(0.5, 0.5));
////            self.scrollView.zoomScale = 1;
//            self.dummyZoomView.transform =CGAffineTransformMakeScale(1,1);
//        } completion:^(BOOL finished) {
//           // self.collectionView.transform = CGAffineTransformMakeScale(1, 1);
//           // self.scrollView.zoomScale = 1.f;
//        }];
//    }else{
//
//        [UIView animateWithDuration:0.5 animations:^{
//            self.collectionView.transform = CGAffineTransformMakeScale(self.doubleTapScale, self.doubleTapScale);
//
//        } completion:^(BOOL finished) {
//            self.collectionView.transform = CGAffineTransformMakeScale(1, 1);
//            self.scrollView.zoomScale = self.doubleTapScale;
//        }];
//    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if([self.layout conformsToProtocol:@protocol(ZJSScalingLayoutProtocol)]){
        id<ZJSScalingLayoutProtocol> obj = (id<ZJSScalingLayoutProtocol>)self.layout;
        CGSize size = [obj contentSizeForScale:self.scrollView.zoomScale];
        self.scrollView.contentSize = size;
        self.dummyZoomView.frame = CGRectMake(0, 0, size.width, size.height);
    }
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
    
   if([self.layout conformsToProtocol:@protocol(ZJSScalingLayoutProtocol)]){
       id<ZJSScalingLayoutProtocol> obj = (id<ZJSScalingLayoutProtocol>)self.layout;
       if ([obj scale] != self.scrollView.zoomScale) {
           [obj setScale:self.scrollView.zoomScale];
           [self.layout invalidateLayout];
           self.collectionView.contentOffset = self.scrollView.contentOffset;
           [self.collectionView hideLingeringCells];
       }
   }

}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    cell.hidden = NO;
}
#pragma mark -
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.bouncesZoom = NO;
    }
    return _scrollView;
}

-(UIView *)dummyZoomView{
    if (!_dummyZoomView) {
        _dummyZoomView = [[UIView alloc] init];
    }
    return _dummyZoomView;
}

@end
