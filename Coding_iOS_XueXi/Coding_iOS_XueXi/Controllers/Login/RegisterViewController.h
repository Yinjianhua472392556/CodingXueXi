//
//  RegisterViewController.h
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "Register.h"

typedef NS_ENUM(NSUInteger, RegisterMethodType) {
    RegisterMethodEamil = 0,
    RegisterMethodPhone,
};

@interface RegisterViewController : BaseViewController
+ (instancetype)vcWithMethodType:(RegisterMethodType)methodType registerObj:(Register *)obj;
@end
