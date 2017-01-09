//
//  AppDelegate.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#define _IPHONE80_ 80000


#import "AppDelegate.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "sys/utsname.h"
#import "Login.h"
#import "RootTabViewController.h"
#import "IntroductionViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



#pragma mark -- lifeCycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //网络
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    //sd加载的数据类型
    [[[SDWebImageManager sharedManager] imageDownloader] setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    //设置导航条样式
    [self customizeInterface];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    //UIWebView 的 User-Agent
    [self registerUserAgent];
    
    if ([Login isLogin]) {
        [self setupTabViewController];
    }else {
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        [self setupIntroductionViewController];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark UserAgent
- (void)registerUserAgent{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], (__bridge id)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(), kCFBundleVersionKey) ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], deviceString, [[UIDevice currentDevice] systemVersion], ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] ? [[UIScreen mainScreen] scale] : 1.0f)];
    NSDictionary *dictionary = @{@"UserAgent" : userAgent};//User-Agent
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}


#pragma mark XGPush

- (void)registerPush {
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (sysVer < 8) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [[UIApplication sharedApplication] registerUserNotificationSettings:userSettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    }
}

#pragma mark - Methods Private

- (void)setupTabViewController {
    RootTabViewController *rootVC = [[RootTabViewController alloc] init];
    rootVC.tabBar.translucent = YES;
    [self.window setRootViewController:rootVC];
}

- (void)setupIntroductionViewController {
    IntroductionViewController *introductionVC = [[IntroductionViewController alloc] init];
    [self.window setRootViewController:introductionVC];
}

- (void)setupLoginViewController {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.window setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:loginVC]];
}

- (void)customizeInterface {
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[NSObject baseURLStrIsProduction]? kColorNavBG: kColorBrandGreen] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTintColor:kColorBrandGreen];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:kNavTitleFontSize], NSForegroundColorAttributeName : kColorNavTitle,};
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [[UITextField appearance] setTintColor:kColorBrandGreen]; //设置UITextField的光标颜色
    [[UITextView appearance] setTintColor:kColorBrandGreen]; //设置UITextView的光标颜色
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:kColorTableSectionBg] forBarPosition:0 barMetrics:UIBarMetricsDefault];
    
}

#pragma mark - Application's Documents directory
// Returns the URL to the application's Documents directory.

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
