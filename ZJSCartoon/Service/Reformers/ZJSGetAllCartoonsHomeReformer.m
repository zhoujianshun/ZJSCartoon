//
//  ZJSGetAllCartoonsHomeReformer.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSGetAllCartoonsHomeReformer.h"

#import <YYModel/YYModel.h>
#import "ZJSCartoonHomeCellViewModel.h"

NSString *const ZJSGetAllCartoonsHomeReformerResultKey = @"cartoons";

NSString *const ZJSGetAllCartoonsHomeResultKey = @"cartoons";
NSString *const ZJSGetAllCartoonsHomeCartoonNameKey = @"cartoonName";
NSString *const ZJSGetAllCartoonsHomeCartoonCoverUrlKey = @"coverUrl";

//NSString *const ZJSGetAllCartoonsHomeResponseKey = @"cartoons";

@implementation ZJSGetAllCartoonsHomeReformer

- (id)reformDataWithManager:(ZJSBaseRequest *)request{
    NSDictionary *originData = request.responseObject;
    if ([request isKindOfClass:[ZJSGetAllCartoonsRequestApi class]]) {
        if (originData) {
            CGSize cellSize = [ZJSCartoonHomeCellViewModel getCellSize];
            NSArray *originList = originData[ZJSGetAllCartoonsHomeResultKey];
            NSMutableArray *array = [NSMutableArray array];
            [originList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    NSString *cartoonName = obj[ZJSGetAllCartoonsHomeCartoonNameKey];
                     NSString *coverUrl = obj[ZJSGetAllCartoonsHomeCartoonCoverUrlKey];
                    ZJSCartoonHomeCellViewModel *vm = [[ZJSCartoonHomeCellViewModel alloc] init];
                    vm.coverUrl = coverUrl;
                    vm.name = cartoonName;
                    vm.cellSize = cellSize;
                    [array addObject:vm];
                }
                
            }];
            
            if (array.count>0) {
                return @{ZJSGetAllCartoonsHomeReformerResultKey : array};
            }
            
        }

    }
    return originData;
}

@end
