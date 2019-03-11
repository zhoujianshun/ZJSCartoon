//
//  ZJSSettingsManager.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/3/11.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSSettingsManager.h"

#import "ZJSNetworkContants.h"
#import "ZJSSettingsContants.h"

@implementation ZJSSettingsManager

+(instancetype)sharedManager{
    static ZJSSettingsManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZJSSettingsManager alloc] init];
    });
    return manager;
}


+(void)saveBaseUrl:(NSString*)url{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:url forKey:ZJS_SETTINGS_URL_KEY];
    [defaults synchronize];
}

+(NSString*)readBaseUrl{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *url = [defaults objectForKey:ZJS_SETTINGS_URL_KEY];
    if (!url) {
        url = k_zjs_network_host;
    }
    return url;
}

-(void)saveServerUrls:(NSArray*)urls{
    [[NSUserDefaults standardUserDefaults] setObject:urls forKey:ZJS_SETTINGS_SERVER_PATH];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSArray*)loadServerUrls{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:ZJS_SETTINGS_SERVER_PATH];
    return array;
}


@end
