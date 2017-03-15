//
//  UIButton+Common.m
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIButton+Common.h"
#import <math.h>
#import <objc/runtime.h>

@interface UIButton()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation UIButton (Common)


#pragma mark -
//开始请求时，UIActivityIndicatorView 提示
static char EAActivityIndicatorKey;

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator {
    objc_setAssociatedObject(self, &EAActivityIndicatorKey, activityIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIActivityIndicatorView *)activityIndicator {
    return objc_getAssociatedObject(self, &EAActivityIndicatorKey);
}

- (void)startQueryAnimate {
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.hidesWhenStopped = YES;
        [self addSubview:self.activityIndicator];
        [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    
    [self.activityIndicator startAnimating];
    self.enabled = NO;
}

- (void)stopQueryAnimate {
    [self.activityIndicator stopAnimating];
    self.enabled = YES;
}

@end
