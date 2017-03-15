//
//  Register.h
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Register : NSObject
//请求
@property (readwrite, nonatomic, strong) NSString *email, *global_key, *j_captcha, *phone, *code, *password, *confirm_password;

+ (NSString *)channel;

- (NSDictionary *)toParams;
@end
