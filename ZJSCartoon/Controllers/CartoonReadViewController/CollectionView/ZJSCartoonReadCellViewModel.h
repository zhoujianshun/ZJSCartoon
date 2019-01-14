//
//  ZJSCartoonReadCellViewModel.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCollectionViewCellBaseViewModel.h"
#import "ZJSCartoonRead.h"


#define k_cartoon_chapter_minimumLineSpacing 0.f
#define k_cartoon_chapter_minimumInteritemSpacing 2.f
#define k_cartoon_chapter_inset UIEdgeInsetsMake(0, 0, 8, 0)
#define k_cartoon_chapter_col 1
#define k_cartoon_chapter_cell_Image_multiply (1530.f/1072.f)

NS_ASSUME_NONNULL_BEGIN

@interface ZJSCartoonReadCellViewModel : ZJSCollectionViewCellBaseViewModel

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, assign) ZJSCartoonReadPageStyle pageStyle;

+(CGSize)getCellSize;

@end

NS_ASSUME_NONNULL_END
