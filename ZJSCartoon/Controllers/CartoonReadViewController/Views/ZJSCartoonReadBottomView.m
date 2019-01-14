//
//  ZJSCartoonReadBottomView.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonReadBottomView.h"

#import <Masonry/Masonry.h>

#import "ZJSScreenUtility.h"

#define kBottomViewContentHeight 50.f

@interface ZJSCartoonReadBottomView()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *layoutTypeButton;

@end

@implementation ZJSCartoonReadBottomView


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
    [self.contentView addSubview:self.layoutTypeButton];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.superview);
        make.trailing.equalTo(self.contentView.superview);
        make.bottom.equalTo(self.contentView.superview);
        make.height.equalTo(@(kBottomViewContentHeight));
    }];
    
    [self.layoutTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.layoutTypeButton.superview);
        make.top.equalTo(self.layoutTypeButton.superview);
        make.bottom.equalTo(self.layoutTypeButton.superview);
//        make.width.equalTo(@(kBackButtonWidth));
    }];
}

#pragma mark - event response
-(void)switchLayoutAction:(UIButton*)sender{
    if (self.switchActionBlock) {
        self.switchActionBlock(self);
    }
}


#pragma mark - getters and setters

-(UIButton *)layoutTypeButton{
    if (!_layoutTypeButton) {
        _layoutTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_layoutTypeButton setTitle:@"竖" forState:UIControlStateNormal];
        [_layoutTypeButton addTarget:self action:@selector(switchLayoutAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _layoutTypeButton;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

#pragma mark -

+(CGFloat)heightForView{
    return [ZJSScreenUtility bottomSafeAreaInset].bottom + kBottomViewContentHeight;
}


@end
