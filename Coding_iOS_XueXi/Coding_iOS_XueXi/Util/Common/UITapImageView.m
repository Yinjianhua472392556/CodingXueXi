//
//  UITapImageView.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UITapImageView.h"

@interface UITapImageView()
@property (nonatomic, copy) void (^tapAction)(id);
@end

@implementation UITapImageView

- (void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage tapBlock:(void (^)(id))tapAction {
    [self sd_setImageWithURL:imgUrl placeholderImage:placeholderImage];
    [self addTapBlock:tapAction];
}

- (void)addTapBlock:(void (^)(id))tapAction {
    self.tapAction = tapAction;
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}

- (void)tap {
    if (self.tapAction) {
        self.tapAction(self);
    }
}

@end
