//
//  NSString+Common.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;
- (NSString *)sha1Str;
- (NSString *)md5Str;
- (NSURL *)urlWithCodePath;
- (NSURL *)urlImageWithCodePathResize:(CGFloat)width;
- (NSURL *)urlImageWithCodePathResize:(CGFloat)width crop:(BOOL)needCrop;
- (NSURL *)urlImageWithCodePathResizeToView:(UIView *)view;


//转换拼音
- (NSString *)transformToPinyin;

@end
