//
//  RKSwipeBetweenViewControllers.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseNavigationController.h"

@protocol RKSwipeBetweenViewControllersDelegate <NSObject>


@end

@interface RKSwipeBetweenViewControllers : BaseNavigationController<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *viewControllerArray;
@property (nonatomic, weak) id<RKSwipeBetweenViewControllersDelegate> navDelegate;
@property (nonatomic, strong, readonly)UIPageViewController *pageController;
@property (nonatomic, strong)UIView *navigationView;
@property (nonatomic, strong)NSArray *buttonText;
+ (instancetype)newSwipeBetweenViewControllers;
- (UIViewController *)curViewController;

@end
