//
//  EasePageViewController.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "EasePageViewController.h"
#import "RKSwipeBetweenViewControllers.h"

@interface EasePageViewController ()

@end

@implementation EasePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark lifeCycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.parentViewController isKindOfClass:[RKSwipeBetweenViewControllers class]]) {
        RKSwipeBetweenViewControllers *swipeVC = (RKSwipeBetweenViewControllers *)self.parentViewController;
        [[swipeVC curViewController] viewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.parentViewController isKindOfClass:[RKSwipeBetweenViewControllers class]]) {
        RKSwipeBetweenViewControllers *swipeVC = (RKSwipeBetweenViewControllers *)self.parentViewController;
        [[swipeVC curViewController] viewWillDisappear:animated];
    }
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

@end
