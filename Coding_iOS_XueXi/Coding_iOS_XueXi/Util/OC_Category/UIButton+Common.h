//
//  UIButton+Common.h
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Common)

//开始请求时，UIActivityIndicatorView 提示
- (void)startQueryAnimate;
- (void)stopQueryAnimate;
@end
