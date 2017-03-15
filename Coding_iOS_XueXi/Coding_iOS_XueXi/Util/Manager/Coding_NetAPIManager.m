//
//  Coding_NetAPIManager.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Coding_NetAPIManager.h"
#import "User.h"
#import "Login.h"

@implementation Coding_NetAPIManager
+ (instancetype)sharedManager {
    static Coding_NetAPIManager *shared_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared_manager = [[self alloc] init];
    });
    
    return shared_manager;
}

#pragma mark UnRead
- (void)request_UnReadCountWithBlock:(void (^)(id, NSError *))block {
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:@"api/user/unread-count" withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            id resultData = [data valueForKeyPath:@"data"];
            block(resultData, nil);
        }else {
            block(nil, error);
        }
    }];
}


#pragma mark Login

- (void)request_Login_With2FA:(NSString *)otpCode andBlock:(void (^)(id, NSError *))block {
    if (otpCode.length <= 0) {
        return;
    }
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:@"api/check_two_factor_auth_code" withParams:@{@"code" : otpCode} withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            User *curLoginUser = [NSObject objectOfClass:@"User" fromJSON:resultData];
            if (curLoginUser) {
                [Login doLogin:resultData];
            }
            block(curLoginUser, nil);
        }else {
            block(nil, error);
        }
    }];
}


- (void)request_Login_WithPath:(NSString *)path Params:(id)params andBlock:(void (^)(id, NSError *))block {
        [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:params withMethodType:Post autoShowError:NO andBlock:^(id data, NSError *error) {
            id resultData = [data valueForKeyPath:@"data"];
            if (resultData) {
                [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:@"api/user/unread-count" withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data_check, NSError *error_check) {//检查当前账号未设置邮箱和GK
                    if (error_check.userInfo[@"msg"][@"user_need_activate"]) {
                        block(nil, error_check);
                    }else {
                        User *curLoginUser = [NSObject objectOfClass:@"User" fromJSON:resultData];
                        if (curLoginUser) {
                            [Login doLogin:resultData];
                        }
                        block(curLoginUser, nil);
                    }
                }];
            }else {
                block(nil, error);
            }
        }];
}

- (void)request_SendActivateEmail:(NSString *)email block:(void (^)(id, NSError *))block {
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:@"api/account/register/email/send" withParams:@{@"email" : email} withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([(NSNumber *)data[@"data"] boolValue]) {
                block(data, nil);
            }else {
                [NSObject showHudTipStr:@"发送失败"];
                block(nil, nil);
            }
        }else {
            block(nil, error);
        }
    }];
}

- (void)request_CaptchaNeededWithPath:(NSString *)path andBlock:(void (^)(id, NSError *))block {
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            id resultData = [data valueForKeyPath:@"data"];
            block(resultData, nil);
        }else {
            block(nil, error);
        }
    }];
}

- (void)request_Register_V2_WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block {
    NSString *path = @"api/v2/account/register";
    [[CodingNetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        id resultData = [data valueForKeyPath:@"data"];
        if (resultData) {
            User *curLoginUser = [NSObject objectOfClass:@"User" fromJSON:resultData];
            if (curLoginUser) {
                [Login doLogin:resultData];
            }
            block(curLoginUser, nil);
        }else {
            block(nil, error);
        }
    }];

}

@end
