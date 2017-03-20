//
//  CannotLoginViewController.h
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/17.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    CannotLoginMethodEamil = 0,
    CannotLoginMethodPhone,
} CannotLoginMethodType;

@interface CannotLoginViewController : BaseViewController
+ (instancetype)vcWithMethodType:(CannotLoginMethodType)methodType
                       stepIndex:(NSUInteger)stepIndex
                         userStr:(NSString *)userStr;
@end
