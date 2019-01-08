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

@interface ZJSCartoonReadCell()

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
    [self.contentView addSubview:self.imageView];
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.superview);
        make.leading.equalTo(self.imageView.superview);
        make.trailing.equalTo(self.imageView.superview);
        make.bottom.equalTo(self.imageView.superview);
    }];
}



#pragma mark - getters and setters
-(void)setViewModel:(ZJSCartoonReadCellViewModel *)viewModel{
    _viewModel = viewModel;
    if (_viewModel.imageUrl) {
        NSURL *url = [NSURL URLWithString:[_viewModel.imageUrl URLEncodeString]];
        [self.imageView sd_setImageWithURL:url];
    }
    
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

@end
