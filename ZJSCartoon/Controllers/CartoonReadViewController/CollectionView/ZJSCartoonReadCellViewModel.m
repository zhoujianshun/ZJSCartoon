//
//  ZJSCartoonReadCellViewModel.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCartoonReadCellViewModel.h"

#import <BFKit/BFKit.h>

@implementation ZJSCartoonReadCellViewModel

+(CGSize)getCellSize{
    CGFloat width = (SCREEN_WIDTH - k_cartoon_chapter_minimumInteritemSpacing * (k_cartoon_chapter_col - 1) -k_cartoon_chapter_inset.left - k_cartoon_chapter_inset.right) / k_cartoon_chapter_col;
    CGFloat heigh = width*k_cartoon_chapter_cell_Image_multiply;
    return CGSizeMake(width, heigh);
}


-(void)setPageStyle:(ZJSCartoonReadPageStyle)pageStyle{
    _pageStyle = pageStyle;
    switch (_pageStyle) {
        case ZJSCartoonReadPageStyleCol:
        {
            CGFloat originWidth = self.imageSize.width;
            CGFloat originHeight = self.imageSize.height;
            if (originWidth>0 && originHeight>0) {
                CGFloat width = SCREEN_WIDTH;
                CGFloat height = width*originHeight/originWidth;
                self.cellSize = CGSizeMake(width, height);
            }else{
                self.cellSize = [ZJSCartoonReadCellViewModel getCellSize];
            }
        }
            break;
            
        default:
        {
            self.cellSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        }
            break;
    }
}

@end
