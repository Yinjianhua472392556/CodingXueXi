//
//  BaseViewController.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "Login.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "RootTabViewController.h"
#import "TweetDetailViewController.h"
#import <RegexKitLite.h>
#import "Project.h"

typedef NS_ENUM(NSUInteger, AnalyseMethodType) {
    AnalyseMethodTypeJustRefresh = 0,
    AnalyseMethodTypeLazyCreate,
    AnalyseMethodTypeForceCreate,
};

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    if (self.interfaceOrientation != UIInterfaceOrientationPortrait
        && !([self supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeLeft)) {
        [self forceChangeToOrientation:UIInterfaceOrientationPortrait];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorTableSectionBg;
    
    if (self.interfaceOrientation != UIInterfaceOrientationPortrait && !([self supportedInterfaceOrientations] & UIInterfaceOrientationMaskLandscapeLeft)) {
        [self forceChangeToOrientation:UIInterfaceOrientationPortrait];
    }
}

- (void)tabBarItemClicked{
    DebugLog(@"\ntabBarItemClicked : %@", NSStringFromClass([self class]));
}

#pragma mark - Orientations

- (BOOL)shouldAutorotate{
    return UIInterfaceOrientationIsLandscape(self.interfaceOrientation);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)forceChangeToOrientation:(UIInterfaceOrientation)interfaceOrientation{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:interfaceOrientation] forKey:@"orientation"];
}

#pragma mark Notification

+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState {
    if (applicationState == UIApplicationStateInactive) {
        //标记为已读

        
        //弹出临时会话

    }else if (applicationState == UIApplicationStateActive) {
    
        //标记未读

    }
}


+ (UIViewController *)analyseVCFromLinkStr:(NSString *)linkStr {

    return [self analyseVCFromLinkStr:linkStr analyseMethod:AnalyseMethodTypeForceCreate isNewVC:nil];
}


+ (UIViewController *)analyseVCFromLinkStr:(NSString *)linkStr analyseMethod:(AnalyseMethodType)methodType isNewVC:(BOOL *)isNewVC {
    DebugLog(@"\n analyseVCFromLinkStr : %@", linkStr);
    if (!linkStr || linkStr.length <= 0) {
        return nil;
    }else if (!([linkStr hasPrefix:@"/"] || [linkStr hasPrefix:kCodingAppScheme] || [linkStr hasPrefix:kBaseUrlStr_Phone] || [linkStr hasPrefix:[NSObject baseURLStr]])) {
        return nil;
    }
    
    UIViewController *analyseVC = nil;
    UIViewController *presentingVC = nil;
    BOOL analyseVCIsNew = YES;
    if (methodType != AnalyseMethodTypeForceCreate) {
        presentingVC = [BaseViewController presentingVC];
    }
    
    NSString *userRegexStr = @"/u/([^/]+)$";//AT某人
    NSString *userTweetRegexStr = @"/u/([^/]+)/bubble$";//某人的冒泡
    NSString *ppRegexStr = @"/u/([^/]+)/pp/([0-9]+)";//冒泡
    NSString *pp_projectRegexStr = @"/[ut]/([^/]+)/p/([^\?]+)[\?]pp=([0-9]+)$";//项目内冒泡(含团队项目)
    NSString *topicRegexStr = @"/[ut]/([^/]+)/p/([^/]+)/topic/(\\d+)";//讨论(含团队项目)
    NSString *taskRegexStr = @"/[ut]/([^/]+)/p/([^/]+)/task/(\\d+)";//任务(含团队项目)
    NSString *fileRegexStr = @"/[ut]/([^/]+)/p/([^/]+)/attachment/([^/]+)/preview/(\\d+)";//文件(含团队项目)
    NSString *gitMRPRCommitRegexStr = @"/[ut]/([^/]+)/p/([^/]+)/git/(merge|pull|commit)/([^/#]+)";//MR(含团队项目)
    NSString *conversionRegexStr = @"/user/messages/history/([^/]+)$";//私信
    NSString *pp_topicRegexStr = @"/pp/topic/([0-9]+)$";//话题
    NSString *codeRegexStr = @"/[ut]/([^/]+)/p/([^/]+)/git/blob/([^/]+)[/]?([^?]*)";//代码(含团队项目)
    NSString *twoFARegexStr = @"/app_intercept/show_2fa";//两步验证
    NSString *projectRegexStr = @"/[ut]/([^/]+)/p/([^/]+)";//项目(含团队项目)
    NSArray *matchedCaptures = nil;

    if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:ppRegexStr]).count > 0) {
        //冒泡
        NSString *user_global_key = matchedCaptures[1];
        NSString *pp_id = matchedCaptures[2];
        if ([presentingVC isKindOfClass:[TweetDetailViewController class]]) {
            TweetDetailViewController *vc = (TweetDetailViewController *)presentingVC;
            if ([vc.curTweet.id.stringValue isEqualToString:pp_id] && [vc.curTweet.owner.global_key isEqualToString:user_global_key]) {
                [vc refreshTweet];
                analyseVCIsNew = NO;
                analyseVC = vc;
            }
        }
        
        if (!analyseVC) {
            TweetDetailViewController *vc = [[TweetDetailViewController alloc] init];
            vc.curTweet = [Tweet tweetWithGlobalKey:user_global_key andPPID:pp_id];
            analyseVC = vc;
        }
    }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:pp_projectRegexStr]).count > 0) {
        //项目内冒泡
        NSString *owner_user_global_key = matchedCaptures[1];
        NSString *project_name = matchedCaptures[2];
        NSString *pp_id = matchedCaptures[3];
        Project *curPro = [Project new];
        curPro.owner_user_name = owner_user_global_key;
        curPro.name = project_name;
        TweetDetailViewController *vc = [[TweetDetailViewController alloc] init];
        vc.curTweet = [Tweet tweetInProject:curPro andPPID:pp_id];
        analyseVC = vc;
    }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:gitMRPRCommitRegexStr]).count > 0) {
        //MR
        NSString *path = [matchedCaptures[0] stringByReplacingOccurrencesOfString:@"https://coding.net" withString:@""];
    }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:topicRegexStr]).count > 0) {
        //讨论

    }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:taskRegexStr]).count > 0) {
        //任务

    }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:fileRegexStr]).count > 0) {
        //文件

    }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:conversionRegexStr]).count > 0) {
        //私信

    }else if (methodType != AnalyseMethodTypeJustRefresh) {
    
        if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:userRegexStr]).count > 0) {
            //AT某人

        }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:userTweetRegexStr]).count > 0) {
            //某人的冒泡

        }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:pp_topicRegexStr]).count > 0) {
            //话题

        }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:codeRegexStr]).count > 0) {
            //代码

        }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:twoFARegexStr]).count > 0) {
            //两步验证

        }else if ((matchedCaptures = [linkStr captureComponentsMatchedByRegex:projectRegexStr]).count > 0) {
            //项目

        }
    }
    
    if (isNewVC) {
        *isNewVC = analyseVCIsNew;
    }
    
    return analyseVC;
}


+ (void)presentLinkStr:(NSString *)linkStr {
    if (!linkStr || linkStr.length == 0) {
        return;
    }
    
    BOOL isNewVC = YES;
    UIViewController *vc = [self analyseVCFromLinkStr:linkStr analyseMethod:AnalyseMethodTypeLazyCreate isNewVC:&isNewVC];
    if (vc && isNewVC) {
        [self presentVC:vc];
    }else if (!vc) {
        if (![linkStr hasPrefix:kCodingAppScheme]) {
            //网页

        }
    }
}


+ (UIViewController *)presentingVC {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    if ([result isKindOfClass:[RootTabViewController class]]) {
        result = [(RootTabViewController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    
    return result;
}

+ (void)presentVC:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    
    UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
    if (!viewController.navigationItem.leftBarButtonItem) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:viewController action:@selector(dismissModalVC)];
    }
    [[self presentingVC] presentViewController:nav animated:YES completion:nil];
}

+ (void)goToVC:(UIViewController *)viewController {
    if (!viewController) {
        return;
    }
    UINavigationController *nav = [self presentingVC].navigationController;
    if (nav) {
        [nav pushViewController:viewController animated:YES];
    }
}

#pragma mark Login

- (void)loginOutToLoginVC {
    [Login doLogout];
    [(AppDelegate *)[UIApplication sharedApplication].delegate setupLoginViewController];
}

@end
