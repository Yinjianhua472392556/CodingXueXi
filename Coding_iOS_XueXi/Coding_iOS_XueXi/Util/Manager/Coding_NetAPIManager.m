//
//  Coding_NetAPIManager.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Coding_NetAPIManager.h"

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

@end
