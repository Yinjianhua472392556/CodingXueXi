//
//  UIBarButtonItem+Common.m
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIBarButtonItem+Common.h"

@implementation UIBarButtonItem (Common)

+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector {
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:obj action:selector];
    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateDisabled];
    return buttonItem;
}

@end
