//
//  TweetDetailViewController.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "Tweets.h"

@interface TweetDetailViewController : BaseViewController
@property (nonatomic, strong) Tweet *curTweet;

- (void)refreshTweet;
@end
