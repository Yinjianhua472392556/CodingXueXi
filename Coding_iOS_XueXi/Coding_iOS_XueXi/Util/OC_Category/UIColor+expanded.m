//
//  UIColor+expanded.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIColor+expanded.h"

@implementation UIColor (expanded)

+ (UIColor *)colorWithString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    if (![scanner scanString:@"{" intoString:NULL]) return nil;
    const NSUInteger kMaxComponents = 4;
    CGFloat c[kMaxComponents];
    NSUInteger i = 0;
    if (![scanner scanFloat:(float *)&c[i++]]) return nil;
    while (1) {
        if ([scanner scanString:@"}" intoString:NULL]) break;
        if (i >= kMaxComponents) return nil;
        if ([scanner scanString:@"," intoString:NULL]) {
            if (![scanner scanFloat:(float *)&c[i++]]) return nil;
        } else {
            // either we're at the end of there's an unexpected character here
            // both cases are error conditions
            return nil;
        }
    }
    if (![scanner isAtEnd]) return nil;
    UIColor *color;
    switch (i) {
        case 2: // monochrome
            color = [UIColor colorWithWhite:c[0] alpha:c[1]];
            break;
        case 4: // RGB
            color = [UIColor colorWithRed:c[0] green:c[1] blue:c[2] alpha:c[3]];
            break;
        default:
            color = nil;
    }
    return color;
}


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


@end
