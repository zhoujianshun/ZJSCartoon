//
//  ZJSScreenUtility.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSScreenUtility.h"



@implementation ZJSScreenUtility


+(BOOL)isiPhoneXScreen{
    if (@available(iOS 11.0, *)) {
        CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        switch ([UIApplication sharedApplication].statusBarOrientation)
        {
            case UIInterfaceOrientationPortrait:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                
            } break;
            case UIInterfaceOrientationLandscapeLeft:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
                
            } break;
            case UIInterfaceOrientationLandscapeRight:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
                
            } break;
            case UIInterfaceOrientationPortraitUpsideDown:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
                
            } break;
            default:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                break;
                
        }
        return iPhoneNotchDirectionSafeAreaInsets > 20;
    } else {
        
    }
    return NO;
}

+(void)scrollViewBottomFitIphoneX:(UIScrollView*)scrollView{
    
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        if (@available(iOS 11.0, *)) {
            scrollView.contentInset = UIEdgeInsetsMake(scrollView.contentInset.top,
                                                       scrollView.contentInset.left,
                                                       scrollView.contentInset.bottom + [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom,
                                                       scrollView.contentInset.right);
            
        } else {
            
        }
    }
    
}
//
//+(CGFloat)bottomSafeArea{
//    if (@available(iOS 11.0, *)) {
//
//        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
//        return safeAreaInsets.bottom;
//    } else {
//        return 0;
//    }
//}
+(UIEdgeInsets)bottomSafeAreaInset{
    if (@available(iOS 11.0, *)) {
        
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        return safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

@end
