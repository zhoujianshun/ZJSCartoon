//
//  ZJSCartoonDetailCell.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonDetailCell.h"

#import <Masonry/Masonry.h>

@interface ZJSCartoonDetailCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZJSCartoonDetailCell

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
    [self.contentView addSubview:self.titleLabel];
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.superview);
        make.leading.equalTo(self.titleLabel.superview);
        make.trailing.equalTo(self.titleLabel.superview);
    }];
}



#pragma mark - getters and setters
-(void)setViewModel:(ZJSCartoonDetailCellViewModel *)viewModel{
    _viewModel = viewModel;
    self.titleLabel.text = _viewModel.chapterName;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
