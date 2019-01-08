//
//  ASTableViewGroupModel.m
//  RippleSENS8
//
//  Created by 周建顺 on 2018/6/21.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import "ZJSTableViewGroupBaseModel.h"

@implementation ZJSTableViewGroupBaseModel

-(CGFloat)footerHeight{
    if (self.footerViewModel) {
        return self.footerViewModel.footerHeight;
    }
    return _footerHeight;
}

-(CGFloat)headerHeight{
    if (self.headerViewModel) {
        return self.headerViewModel.headerHeight;
    }
    return _headerHeight;
}

@end
