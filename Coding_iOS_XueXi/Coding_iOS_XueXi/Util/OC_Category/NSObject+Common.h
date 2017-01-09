//
//  NSObject+Common.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)
#pragma mark BaseURL
+ (NSString *)baseURLStr;
+ (BOOL)baseURLStrIsProduction;
+ (void)changeBaseURLStrTo:(NSString *)baseURLStr;


#pragma mark NetError
-(id)handleResponse:(id)responseJSON;
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;

//网络请求
+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;//缓存请求回来的json对象
+ (id)loadResponseWithPath:(NSString *)requestPath;//返回一个NSDictionary类型的json数据
+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath;
+ (BOOL)deleteResponseCache;
+ (NSUInteger)getResponseCacheSize;

#pragma mark Tip M
+ (void)showHudTipStr:(NSString *)tipStr;
+ (BOOL)showError:(NSError *)error;

@end
