//
//  ZJSGetCartoonChapterDetailReformer.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSGetCartoonChapterDetailReformer.h"

#import "ZJSCartoonReadCellViewModel.h"


NSString *const ZJSGetCartoonChapterReformerResultKey = @"ZJSGetCartoonChapterReformerResultKey";
NSString *const ZJSGetCartoonChapterImagesKey=@"images";
NSString *const ZJSGetCartoonChapterImageUrlKey=@"url";
NSString *const ZJSGetCartoonChapterImageWidthKey=@"width";
NSString *const ZJSGetCartoonChapterImageHeightKey=@"height";

@implementation ZJSGetCartoonChapterDetailReformer


- (id)reformDataWithManager:(ZJSBaseRequest *)request{
    NSDictionary *originData = request.responseObject;
    if ([request isKindOfClass:[ZJSGetCartoonChapterDetailRequestApi class]]) {
        if (originData) {
            CGSize cellSize = [ZJSCartoonReadCellViewModel getCellSize];
            NSArray *originList = originData[ZJSGetCartoonChapterImagesKey];
            NSMutableArray *array = [NSMutableArray array];
            [originList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    ZJSCartoonReadCellViewModel *vm = [[ZJSCartoonReadCellViewModel alloc] init];
                    
                    NSDictionary *dict = obj;
                    NSString *url = dict[ZJSGetCartoonChapterImageUrlKey];
                    CGFloat originWidth = [dict[ZJSGetCartoonChapterImageWidthKey] floatValue];
                    CGFloat originHeight = [dict[ZJSGetCartoonChapterImageHeightKey] floatValue];
                    vm.imageSize = CGSizeMake(originWidth, originHeight);
                    vm.imageUrl = url;
                    vm.pageStyle = self.pageStyle;
                    
                    [array addObject:vm];
                }
                
            }];
            
            if (array.count>0) {
                return @{ZJSGetCartoonChapterReformerResultKey : array};
            }
            
        }
        
    }
    return originData;
}

@end
