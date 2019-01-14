//
//  ZJSCartoonReadTopView.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonReadTopView.h"

#import <Masonry/Masonry.h>

#define kTopViewContentHeight 44.f

#define kBackButtonWidth 44.f

@interface ZJSCartoonReadTopView()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation ZJSCartoonReadTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}


-(void)commonInit{
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.backButton];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.superview);
        make.trailing.equalTo(self.contentView.superview);
        make.bottom.equalTo(self.contentView.superview);
        make.height.equalTo(@(kTopViewContentHeight));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backButton.superview);
        make.top.equalTo(self.backButton.superview);
        make.bottom.equalTo(self.backButton.superview);
        make.width.equalTo(@(kBackButtonWidth));
    }];
}

#pragma mark - event response

-(void)backAction:(UIButton*)sender{
    if (self.backActionBlock) {
        self.backActionBlock(self);
    }
}


#pragma mark - getters and setters

-(UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitle:@"<" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

#pragma mark -

+(CGFloat)heightForStatusBarHidden:(BOOL)hidden{
    if (hidden) {
        return kTopViewContentHeight;
    }else{
        return [UIApplication sharedApplication].statusBarFrame.size.height + kTopViewContentHeight;
    }
}



@end
