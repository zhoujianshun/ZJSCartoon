//
//  ZJSScalingLayoutProtocol.h
//  ZJSCollectionView_Test
//
//  Created by 周建顺 on 2019/1/8.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZJSScalingLayoutProtocol <NSObject>
//
//func getScale() -> CGFloat
//func setScale(_ scale: CGFloat) -> Void
//func contentSizeForScale(_ scale: CGFloat) -> CGSize

-(CGFloat)scale;
-(void)setScale:(CGFloat)scale;
-(CGSize)contentSizeForScale:(CGFloat)scale;



@end

NS_ASSUME_NONNULL_END
