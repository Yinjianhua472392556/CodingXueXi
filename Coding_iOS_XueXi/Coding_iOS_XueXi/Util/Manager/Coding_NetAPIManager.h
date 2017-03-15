//
//  Coding_NetAPIManager.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodingNetAPIClient.h"

@interface Coding_NetAPIManager : NSObject
+ (instancetype)sharedManager;

#pragma mark - UnRead
- (void)request_UnReadCountWithBlock:(void (^)(id data, NSError *error))block;
- (void)request_UnReadNotificationsWithBlock:(void (^)(id data, NSError *error))block;


#pragma mark - Login

- (void)request_CaptchaNeededWithPath:(NSString *)path
                             andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Login_With2FA:(NSString *)otpCode
                     andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Login_WithPath:(NSString *)path
                        Params:(id)params
                      andBlock:(void (^)(id data, NSError *error))block;
- (void)request_SendActivateEmail:(NSString *)email
                            block:(void (^)(id data, NSError *error))block;

- (void)request_Register_V2_WithParams:(NSDictionary *)params
                              andBlock:(void (^)(id data, NSError *error))block;
@end
