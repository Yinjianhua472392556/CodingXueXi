//
//  Register.m
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Register.h"

@implementation Register

- (instancetype)init {
    self = [super init];
    if (self) {
        self.email = @"";
        self.global_key = @"";
    }
    return self;
}

- (NSDictionary *)toParams{
    return @{@"email" : self.email,
             @"global_key" : self.global_key,
             @"j_captcha" : _j_captcha? _j_captcha: @"",
             @"channel" : [Register channel]};
}

+ (NSString *)channel{
    return @"coding-ios";
}

@end
