//
//  ZJSCartoonHomeCellViewModel.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCollectionViewCellBaseViewModel.h"

#import <UIKit/UIKit.h>

#define k_cartoon_home_minimumLineSpacing 4.f
#define k_cartoon_home_minimumInteritemSpacing 2.f
#define k_cartoon_home_inset UIEdgeInsetsMake(0, 0, 8, 0)
#define k_cartoon_home_col 3
#define k_cartoon_home_cell_Image_multiply (3.f/2.f)
#define k_cartoon_home_cell_bottom 30.f

NS_ASSUME_NONNULL_BEGIN

@interface ZJSCartoonHomeCellViewModel : ZJSCollectionViewCellBaseViewModel

@property (nonatomic, copy) NSString *coverUrl;
@property (nonatomic, copy) NSString *name;

+(CGSize)getCellSize;

@end

NS_ASSUME_NONNULL_END
