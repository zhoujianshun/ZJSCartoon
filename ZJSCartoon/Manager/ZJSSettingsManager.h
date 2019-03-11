//
//  ZJSSettingsManager.h
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/3/11.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSSettingsManager : NSObject

+(instancetype)sharedManager;

+(void)saveBaseUrl:(NSString*)url;
+(NSString*)readBaseUrl;

-(void)saveServerUrls:(NSArray*)urls;
-(NSArray*)loadServerUrls;

@end

NS_ASSUME_NONNULL_END
