//
//  ASCollectionViewGroupBaseViewModel.h
//  RippleSENS8
//
//  Created by 周建顺 on 2018/7/20.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZJSCollectionViewCellBaseViewModel.h"
#import "ZJSCollectionViewHeaderBaseViewModel.h"
#import "ZJSCollectionViewFooterBaseViewModel.h"

@interface ZJSCollectionViewGroupBaseViewModel : NSObject

@property (nonatomic, strong) ZJSCollectionViewHeaderBaseViewModel *headerViewModel;
@property (nonatomic, strong) ZJSCollectionViewFooterBaseViewModel *footerViewModel;
@property (nonatomic, copy) NSArray<ZJSCollectionViewCellBaseViewModel*> *datas;

@property (nonatomic) CGSize headerSize;
@property (nonatomic) CGSize footerSize;

-(CGSize)headerSize;
-(CGSize)footerSize;

@end
