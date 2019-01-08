//
//  ZJSCartoonDetailCellViewModel.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCollectionViewCellBaseViewModel.h"

#define k_cartoon_detail_minimumLineSpacing 4.f
#define k_cartoon_detail_minimumInteritemSpacing 2.f
#define k_cartoon_detail_inset UIEdgeInsetsMake(0, 0, 8, 0)
#define k_cartoon_detail_col 3
#define k_cartoon_detail_height 35


NS_ASSUME_NONNULL_BEGIN

@interface ZJSCartoonDetailCellViewModel : ZJSCollectionViewCellBaseViewModel

@property (nonatomic, copy) NSString *chapterName;

+(CGSize)getCellSize;

@end

NS_ASSUME_NONNULL_END
