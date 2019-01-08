//
//  ZJSCartoonHomeCellViewModel.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonHomeCellViewModel.h"
#import <BFKit/BFKit.h>

@implementation ZJSCartoonHomeCellViewModel

+(CGSize)getCellSize{
    CGFloat width = (SCREEN_WIDTH - k_cartoon_home_minimumInteritemSpacing * (k_cartoon_home_col - 1) -k_cartoon_home_inset.left - k_cartoon_home_inset.right) / k_cartoon_home_col;
    CGFloat heigh = width*k_cartoon_home_cell_Image_multiply + k_cartoon_home_cell_bottom;
    return CGSizeMake(width, heigh);
}

@end
