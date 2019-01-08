//
//  ASCollectionViewGroupBaseViewModel.m
//  RippleSENS8
//
//  Created by 周建顺 on 2018/7/20.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import "ZJSCollectionViewGroupBaseViewModel.h"

@implementation ZJSCollectionViewGroupBaseViewModel

-(CGSize)headerSize{
    if (self.headerViewModel) {
        return self.headerViewModel.headerSize;
    }
    return _headerSize;
}

-(CGSize)footerSize{
    if (self.footerViewModel) {
        return self.footerViewModel.footerSize;
    }
    return _footerSize;
}

@end
