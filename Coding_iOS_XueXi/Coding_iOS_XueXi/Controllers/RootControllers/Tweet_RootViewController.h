//
//  Tweet_RootViewController.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "ODRefreshControl.h"
#import "Tweets.h"


typedef NS_ENUM(NSUInteger, Tweet_RootViewControllerType){
    Tweet_RootViewControllerTypeAll = 0,
    Tweet_RootViewControllerTypeFriend,
    Tweet_RootViewControllerTypeHot,
    Tweet_RootViewControllerTypeMine
};

@interface Tweet_RootViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
+ (instancetype)newTweetVCWithType:(Tweet_RootViewControllerType)type;
@end
