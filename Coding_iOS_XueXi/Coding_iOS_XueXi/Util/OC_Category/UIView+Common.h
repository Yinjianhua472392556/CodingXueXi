//
//  UIView+Common.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color;

- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
@end
