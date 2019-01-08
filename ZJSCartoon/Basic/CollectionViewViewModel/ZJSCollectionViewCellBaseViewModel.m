//
//  ASCollectionViewBaseViewModel.m
//  RippleSENS8
//
//  Created by 周建顺 on 2018/7/20.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import "ZJSCollectionViewCellBaseViewModel.h"

@implementation ZJSCollectionViewCellBaseViewModel

-(void)cellTappedAction{
    if (self.cellTappedActionBlock) {
        self.cellTappedActionBlock(self);
    }
}



@end
