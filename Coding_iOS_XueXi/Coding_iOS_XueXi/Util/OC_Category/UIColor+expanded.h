//
//  UIColor+expanded.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (expanded)

+ (UIColor *)colorWithString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;

@end
