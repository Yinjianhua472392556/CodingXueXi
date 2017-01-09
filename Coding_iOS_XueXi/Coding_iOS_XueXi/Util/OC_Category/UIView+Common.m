//
//  UIView+Common.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
