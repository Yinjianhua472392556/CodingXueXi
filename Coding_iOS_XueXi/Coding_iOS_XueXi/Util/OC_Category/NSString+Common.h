//
//  NSString+Common.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

+ (NSString *)userAgentStr;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;
- (NSString *)sha1Str;
- (NSString *)md5Str;
- (NSURL *)urlWithCodePath;
- (NSURL *)urlImageWithCodePathResize:(CGFloat)width;
- (NSURL *)urlImageWithCodePathResize:(CGFloat)width crop:(BOOL)needCrop;
- (NSURL *)urlImageWithCodePathResizeToView:(UIView *)view;


- (NSString *)trimWhitespace;

- (NSRange)rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSRange)rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;


//转换拼音
- (NSString *)transformToPinyin;


//判断是否为整形
- (BOOL)isPureInt;

//判断是否为浮点形
- (BOOL)isPureFloat;

//判断是否是手机号码或者邮箱
- (BOOL)isPhoneNo;
- (BOOL)isEmail;
- (BOOL)isGK;


@end
