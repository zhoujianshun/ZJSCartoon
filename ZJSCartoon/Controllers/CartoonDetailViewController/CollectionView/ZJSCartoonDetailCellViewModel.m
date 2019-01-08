//
//  ZJSCartoonDetailCellViewModel.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonDetailCellViewModel.h"

#import <BFKit/BFKit.h>

@implementation ZJSCartoonDetailCellViewModel

+(CGSize)getCellSize{
    CGFloat width = (SCREEN_WIDTH - k_cartoon_detail_minimumInteritemSpacing * (k_cartoon_detail_col - 1) -k_cartoon_detail_inset.left - k_cartoon_detail_inset.right) / k_cartoon_detail_col;
    CGFloat heigh = k_cartoon_detail_height;
    return CGSizeMake(width, heigh);
}

@end
