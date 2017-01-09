//
//  CodingNetAPIClient.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

typedef NS_ENUM(NSInteger, IllegalContentType) {
    IllegalContentTypeTweet = 0,
    IllegalContentTypeTopic,
    IllegalContentTypeProject,
    IllegalContentTypeWebsite
};

@interface CodingNetAPIClient : AFHTTPRequestOperationManager

+ (id)sharedJsonClient;
+ (id)changeJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary *)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                           file:(NSDictionary *)file
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;


- (void)reportIllegalContentWithType:(IllegalContentType)type
                          withParams:(NSDictionary*)params;

- (void)uploadImage:(UIImage *)image
               path:(NSString *)path
               name:(NSString *)name
       successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
       failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
      progressBlock:(void (^)(CGFloat progressValue))progress;

- (void)uploadVoice:(NSString *)file
           withPath:(NSString *)path
         withParams:(NSDictionary*)params
           andBlock:(void (^)(id data, NSError *error))block;
@end
