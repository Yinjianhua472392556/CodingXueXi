//
//  Project.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Project : NSObject
@property (readwrite, nonatomic, strong) NSString *icon, *name, *owner_user_name, *backend_project_path, *full_name, *description_mine, *path, *parent_depot_path, *current_user_role,*project_path;
@property (readwrite, nonatomic, strong) NSNumber *id, *owner_id, *is_public, *un_read_activities_count, *done, *processing, *star_count, *stared, *watch_count, *watched, *fork_count, *forked, *recommended, *pin, *current_user_role_id, *type, *gitReadmeEnabled, *max_member;
@property (assign, nonatomic) BOOL isStaring, isWatching, isLoadingMember, isLoadingDetail;
@property (strong, nonatomic) User *owner;

@property (strong, nonatomic) NSDate *created_at,*updated_at;
@end
