//
//  BaseViewController.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)tabBarItemClicked;
- (void)loginOutToLoginVC;

+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState;
+ (UIViewController *)analyseVCFromLinkStr:(NSString *)linkStr;
+ (void)presentLinkStr:(NSString *)linkStr;
+ (UIViewController *)presentingVC;
+ (void)presentVC:(UIViewController *)viewController;
+ (void)goToVC:(UIViewController *)viewController;
@end
