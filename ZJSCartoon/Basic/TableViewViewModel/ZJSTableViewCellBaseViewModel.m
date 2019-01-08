//
//  ASTableViewCellBaseViewModel.m
//  RippleSENS8
//
//  Created by 周建顺 on 2018/6/21.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import "ZJSTableViewCellBaseViewModel.h"

@implementation ZJSTableViewCellBaseViewModel

-(void)cellTappedAction{
    if (self.cellTappedActionBlock) {
        self.cellTappedActionBlock(self);
    }
}

@end
