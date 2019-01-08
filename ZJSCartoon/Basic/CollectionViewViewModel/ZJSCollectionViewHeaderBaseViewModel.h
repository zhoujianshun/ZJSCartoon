//
//  ASCollectionViewHeaderBaseViewModel.h
//  RippleSENS8
//
//  Created by 周建顺 on 2018/7/20.
//  Copyright © 2018年 RippleInfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZJSCollectionViewHeaderBaseViewModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic) CGSize headerSize;

-(CGSize)headerSize;

@end
