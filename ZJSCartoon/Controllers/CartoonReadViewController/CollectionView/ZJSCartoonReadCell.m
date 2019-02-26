//
//  ZJSCartoonReadCell.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonReadCell.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "NSString+ZJSUrlCode.h"

@interface ZJSCartoonReadCell()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZJSCartoonReadCell

#pragma mark - life cycle

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.imageView.superview);
//        make.leading.equalTo(self.imageView.superview);
//        make.trailing.equalTo(self.imageView.superview);
//        make.bottom.equalTo(self.imageView.superview);
//    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.superview);
        make.leading.equalTo(self.scrollView.superview);
        make.trailing.equalTo(self.scrollView.superview);
        make.bottom.equalTo(self.scrollView.superview);
    }];
}


#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                        scrollView.contentSize.height * 0.5 + offsetY);
    
}

#pragma mark - getters and setters
-(void)setViewModel:(ZJSCartoonReadCellViewModel *)viewModel{
    _viewModel = viewModel;
    self.scrollView.zoomScale = 1.f;
    if (_viewModel.imageUrl) {
        NSURL *url = [NSURL URLWithString:[_viewModel.imageUrl URLEncodeString]];
        typeof(self) weakself = self;
        [self.imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                [weakself updateLayoutImageViewWithImage:image];
            }
            
        }];
    }
    

}

-(void)updateLayoutImageViewWithImage:(UIImage*)image{
    CGSize imageSize = image.size;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    
    if (imageSize.height/imageSize.width>(height/width)) {
        self.imageView.frame = CGRectMake(0, 0, imageSize.width/imageSize.height*height, height);
        self.imageView.center = CGPointMake(width/2.f, height/2.f);
    }else{
        self.imageView.frame = CGRectMake(0, 0, width, imageSize.height/imageSize.width*width);
        self.imageView.center = CGPointMake(width/2.f, height/2.f);
    }
}
    

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 3.f;
        _scrollView.minimumZoomScale = 1.f;
        _scrollView.zoomScale = 1.f;
        
    }
    return _scrollView;
}

@end
