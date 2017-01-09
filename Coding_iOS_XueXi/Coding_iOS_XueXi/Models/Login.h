//
//  Login.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Login : NSObject

//请求
@property (readwrite, nonatomic, strong) NSString *email, *password, *j_captcha;
@property (readwrite, nonatomic, strong) NSNumber *remember_me;

- (NSString *)goToLoginTipWithCaptcha:(BOOL)needCaptcha;
- (NSString *)toPath;
- (NSDictionary *)toParams;


+ (BOOL) isLogin;
+ (void) doLogin:(NSDictionary *)loginData;
+ (void) doLogout;
+ (User *)curLoginUser;

+ (NSMutableDictionary *)readLoginDataList;
+ (void)setPreUserEmail:(NSString *)emailStr;
+ (NSString *)preUserEmail;
+ (User *)userWithGlobaykeyOrEmail:(NSString *)textStr;
+ (BOOL)isLoginUserGlobalKey:(NSString *)global_key;

@end
