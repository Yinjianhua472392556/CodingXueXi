//
//  NSObject+Common.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSObject+Common.h"
#import "CodingNetAPIClient.h"

#define kBaseURLStr @"https://coding.net/"


@implementation NSObject (Common)

#pragma mark BaseURL
+ (NSString *)baseURLStr {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:kBaseURLStr] ?:kBaseURLStr;
}

+ (BOOL)baseURLStrIsProduction {
    return [[self baseURLStr] isEqualToString:kBaseURLStr];
}

+ (void)changeBaseURLStrTo:(NSString *)baseURLStr {
    if (baseURLStr.length <= 0) {
        baseURLStr = kBaseURLStr;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:baseURLStr forKey:kBaseURLStr];
    [defaults synchronize];
    
    [CodingNetAPIClient changeJsonClient];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[self baseURLStrIsProduction]? kColorNavBG : kColorBrandGreen] forBarMetrics:UIBarMetricsDefault];
}

@end
