//
//  ASTableViewHeaderBaseViewModel.h
//  RippleSENS8
//
//  Created by 周建顺 on 2018/6/21.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZJSTableViewHeaderBaseViewModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic) CGFloat headerHeight;

-(CGFloat)headerHeight;


@end
