//
//  ZJSCartoonHomeCollectionViewCell.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonHomeCollectionViewCell.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "NSString+ZJSUrlCode.h"

@interface ZJSCartoonHomeCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation ZJSCartoonHomeCollectionViewCell

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
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.label];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.superview);
        make.leading.equalTo(self.imageView.superview);
        make.trailing.equalTo(self.imageView.superview);
        make.height.equalTo(self.imageView.mas_width).multipliedBy(k_cartoon_home_cell_Image_multiply);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.leading.equalTo(self.bottomView.superview);
        make.trailing.equalTo(self.bottomView.superview);
        make.bottom.equalTo(self.bottomView.superview);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label.superview);
        make.trailing.equalTo(self.label.superview);
        make.centerY.equalTo(self.bottomView);
    }];
}


#pragma mark - getters and setters
-(void)setViewModel:(ZJSCartoonHomeCellViewModel *)viewModel{
    _viewModel = viewModel;
    if (_viewModel.coverUrl) {
        
        NSURL *url = [NSURL URLWithString:[_viewModel.coverUrl URLEncodeString]];
        [self.imageView sd_setImageWithURL:url];
    }
   
    self.label.text = _viewModel.name;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 1;
        _label.font = [UIFont systemFontOfSize:14.f];
    }
    return _label;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imageView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
//        _bottomView.backgroundColor = [UIColor grayColor];
    }
    return _bottomView;
}

@end
