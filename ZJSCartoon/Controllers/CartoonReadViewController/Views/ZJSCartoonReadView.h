//
//  ZJSCartoonReadView.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/14.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZJSCartoonRead.h"
#import "ZJSCartoonReadCell.h"

@class ZJSCartoonReadView;

@protocol ZJSCartoonReadViewDelegate <NSObject>

-(void)ZJSCartoonReadViewDidScroll:(ZJSCartoonReadView*)cartoonReadView;
-(void)ZJSCartoonReadViewRefresh:(ZJSCartoonReadView*)cartoonReadView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZJSCartoonReadView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray<ZJSCollectionViewCellBaseViewModel*> *datas;
@property (nonatomic, assign) ZJSCartoonReadPageStyle pageStyle;
@property (nonatomic, weak) id<ZJSCartoonReadViewDelegate>  delegate;


-(void)endRefresh;
-(void)reloadData;

-(void)switchLayout;

@end

NS_ASSUME_NONNULL_END
