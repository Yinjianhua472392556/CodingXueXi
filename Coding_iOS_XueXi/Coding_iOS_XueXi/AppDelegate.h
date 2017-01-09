//
//  AppDelegate.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSURL *)applicationDocumentsDirectory;
- (void)setupTabViewController;
- (void)setupLoginViewController;
- (void)setupIntroductionViewController;

/**
 *  注册推送
 */
- (void)registerPush;

@end

