//
//  Tweet.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Project.h"

@interface Tweet : NSObject
@property (readwrite, nonatomic, strong) NSString *content, *device, *location, *coord, *address;
@property (readwrite, nonatomic, strong) NSNumber *liked, *rewarded, *activity_id, *id, *comments, *likes, *rewards;
@property (readwrite, nonatomic, strong) NSDate *created_at, *sort_time;
@property (readwrite, nonatomic, strong) User *owner;
@property (readwrite, nonatomic, strong) NSMutableArray *comment_list, *like_users, *reward_users;
@property (readwrite, nonatomic, strong) NSDictionary *propertyArrayMap;
@property (assign, nonatomic) BOOL canLoadMore, willLoadMore, isLoading;




+ (Tweet *)tweetWithGlobalKey:(NSString *)user_global_key andPPID:(NSString *)pp_id;
+ (Tweet *)tweetInProject:(Project *)project andPPID:(NSString *)pp_id;

@end
