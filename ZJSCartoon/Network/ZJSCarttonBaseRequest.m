//
//  ZJSCarttonBaseRequest.m
//  ZJSCartoon
//
//  Created by 周建顺 on 2019/1/14.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSCarttonBaseRequest.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface ZJSCarttonBaseRequest()

@property (nonatomic, weak) MBProgressHUD  *loadingHud;
@property (nonatomic, weak) MBProgressHUD  *errorHud;

@end

@implementation ZJSCarttonBaseRequest


-(void)start{
    [super start];
    
    if (!self.hiddenLoading) {
        [self showLoadingView];
    }
}

-(NSTimeInterval)requestTimeoutInterval{
    return 15.f;
}

-(void)requestCompleteFilter{
    [super requestCompleteFilter];
    if (!self.hiddenLoading) {
        [self hiddenLoadingView];
    }
    
}

-(void)requestFailedFilter{
    [super requestFailedFilter];
    if (!self.hiddenLoading) {
        [self hiddenLoadingView];
    }
    
    if (!self.hiddenError) {
        [self showErrorMessage];
    }
}

-(void)showLoadingView{
    if (!self.hudParentView) {
        return;
    }
    if ([NSThread isMainThread]) {
        self.loadingHud = [MBProgressHUD showHUDAddedTo:self.hudParentView animated:YES];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.loadingHud = [MBProgressHUD showHUDAddedTo:self.hudParentView animated:YES];
        });
    }

}

-(void)hiddenLoadingView{
    [self.loadingHud hideAnimated:YES];
    //[MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
}

-(void)showErrorMessage{
    if (!self.hudParentView) {
        return;
    }
    NSString *errorMsg = [self.error localizedDescription];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.hudParentView animated:YES];

    self.errorHud = hud;
    
    hud.label.text = errorMsg;
    hud.mode = MBProgressHUDModeText;

    [hud hideAnimated:YES afterDelay:3.f];
    
}

@end
