//
//  Tweet_RootViewController.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Tweet_RootViewController.h"

@interface Tweet_RootViewController ()

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) ODRefreshControl *refreshControl;

@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, strong) NSMutableDictionary *tweetsDict;
@end

@implementation Tweet_RootViewController

+ (instancetype)newTweetVCWithType:(Tweet_RootViewControllerType)type {
    Tweet_RootViewController *vc = [[Tweet_RootViewController alloc] init];
    vc.curIndex = type;
    return vc;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _curIndex = 0;
        _tweetsDict = [[NSMutableDictionary alloc] initWithCapacity:4];
    }
    
    return self;
}


#pragma mark TabBar

- (void)tabBarItemClicked {
    [super tabBarItemClicked];
    if (_myTableView.contentOffset.y > 0) {
        [_myTableView setContentOffset:CGPointZero animated:YES];
    }else if (!self.refreshControl.isAnimating) {
        [self.refreshControl beginRefreshing];
        [self.myTableView setContentOffset:CGPointMake(0, -44)];
        [self refresh];
    }
}


#pragma mark lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark Banner


@end
