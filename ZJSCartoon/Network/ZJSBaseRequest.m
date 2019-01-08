//
//  ZJSBaseRequest.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/3.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSBaseRequest.h"

@implementation ZJSBaseRequest


-(id)fetchDataWithReformer:(id<ZJSReformerProtocol>)reformer{
    if (reformer) {
        return [reformer reformDataWithManager:self];
    }
    return self.responseObject;
}

@end
