//
//  ZJSScreenUtility.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ZJSScreenUtility : NSObject

/**
 判断是否有刘海
 
 @return <#return value description#>
 */
+(BOOL)isiPhoneXScreen;


/**
 scrollview适配iohonex
 
 @param scrollView <#scrollView description#>
 */
+(void)scrollViewBottomFitIphoneX:(UIScrollView*)scrollView;

+(UIEdgeInsets)bottomSafeAreaInset;

@end

NS_ASSUME_NONNULL_END
