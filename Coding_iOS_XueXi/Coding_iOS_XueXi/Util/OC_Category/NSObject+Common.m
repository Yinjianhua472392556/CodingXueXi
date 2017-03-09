//
//  NSObject+Common.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSObject+Common.h"
#import "CodingNetAPIClient.h"
#import "HtmlMedia.h"

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


#pragma mark Tip M

+ (NSString *)tipFromError:(NSError *)error {
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if ([error.userInfo objectForKey:@"msg"]) {
            NSArray *msgArray = [[error.userInfo objectForKey:@"msg"] allValues];
            NSUInteger num = [msgArray count];
            for (int i = 0; i < num; i++) {
                NSString *msgStr = [msgArray objectAtIndex:i];
                HtmlMedia *media = [HtmlMedia htmlMediaWithString:msgStr showType:MediaShowTypeAll];
                msgStr = media.contentDisplay;
                if (i + 1 < num) {
                    [tipStr appendString:[NSString stringWithFormat:@"%@\n", msgStr]];
                }else {
                    [tipStr appendString:msgStr];
                }
            }
        }else {
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else {
                [tipStr appendFormat:@"ErrorCode%ld", (long)error.code];
            }
        }
        
        return tipStr;
    }
    
    return nil;
}

+ (BOOL)showError:(NSError *)error {
    if ([JDStatusBarNotification isVisible]) {//如果statusBar上面正在显示信息，则不再用hud显示error
        NSLog(@"如果statusBar上面正在显示信息，则不再用hud显示error");
        return NO;
    }
    
    NSString *tipStr = [NSObject tipFromError:error];
    [NSObject showHudTipStr:tipStr];
    return YES;
}


+ (void)showHudTipStr:(NSString *)tipStr {
    if (tipStr && tipStr.length > 0) {
        
    }
}

@end
