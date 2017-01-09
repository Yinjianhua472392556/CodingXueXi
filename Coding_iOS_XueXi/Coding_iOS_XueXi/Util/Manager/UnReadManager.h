//
//  UnReadManager.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnReadManager : NSObject
@property (strong, nonatomic) NSNumber *messages, *notifications, *project_update_count;
+ (instancetype)shareManager;
- (void)updateUnRead;
@end
