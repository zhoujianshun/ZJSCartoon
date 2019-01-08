//
//  ZJSGetCartoonDetailReformer.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/7.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSGetCartoonDetailReformer.h"

#import "ZJSCartoonDetailCellViewModel.h"

NSString *const ZJSGetCartoonDatailReformerResultKey = @"ZJSGetCartoonDatailReformerResultKey";

NSString *const ZJSGetCartoonDatailChaptersKey = @"chapters";

@implementation ZJSGetCartoonDetailReformer


- (id)reformDataWithManager:(ZJSBaseRequest *)request{
    NSDictionary *originData = request.responseObject;
    if ([request isKindOfClass:[ZJSGetCartoonDetailRequestApi class]]) {
        if (originData) {
            CGSize cellSize = [ZJSCartoonDetailCellViewModel getCellSize];
            NSArray *originList = originData[ZJSGetCartoonDatailChaptersKey];
            NSMutableArray *array = [NSMutableArray array];
            [originList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSString class]]) {
            
                    ZJSCartoonDetailCellViewModel *vm = [[ZJSCartoonDetailCellViewModel alloc] init];
                    vm.chapterName = obj;
                    vm.cellSize = cellSize;
                    [array addObject:vm];
                }
                
            }];
            
            if (array.count>0) {
                return @{ZJSGetCartoonDatailReformerResultKey : array};
            }
            
        }
        
    }
    return originData;
}

@end
