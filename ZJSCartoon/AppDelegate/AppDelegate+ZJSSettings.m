//
//  AppDelegate+ZJSSettings.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/4.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "AppDelegate+ZJSSettings.h"

#import "YTKNetwork.h"
#import "ZJSSettingsManager.h"


@implementation AppDelegate (ZJSSettings)

-(BOOL)zjs_settings{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = [ZJSSettingsManager readBaseUrl];

    return YES;
}


@end
