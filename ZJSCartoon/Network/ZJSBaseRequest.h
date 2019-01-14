//
//  ZJSBaseRequest.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/3.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>


@class ZJSBaseRequest;

NS_ASSUME_NONNULL_BEGIN

/**
 实现该协议，返回重新构造的用于业务层的数据。
 参考：https://casatwy.com/iosying-yong-jia-gou-tan-wang-luo-ceng-she-ji-fang-an.html
 */
@protocol ZJSReformerProtocol<NSObject>

- (id)reformDataWithManager:(ZJSBaseRequest *)request;

@end

@interface ZJSBaseRequest : YTKBaseRequest

/**
 根据输入的reformer，返回业务层相关的数据
 
 @param reformer <#reformer description#>
 @return <#return value description#>
 */
- (id)fetchDataWithReformer:(id<ZJSReformerProtocol>)reformer;

@end

NS_ASSUME_NONNULL_END
