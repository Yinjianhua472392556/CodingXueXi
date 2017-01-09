//
//  EaseInputTipsView.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EaseInputTipsViewType) {
    EaseInputTipsViewTypeLogin = 0,
    EaseInputTipsViewTypeRegister,
};

@interface EaseInputTipsView : UIView
@property (nonatomic, strong) NSString *valueStr;
@property (nonatomic, assign, getter=isActive) BOOL active;
@property (nonatomic, assign, readonly) EaseInputTipsViewType type;

@property (nonatomic, copy) void (^selectedStringBlock)(NSString *);

+ (instancetype)tipsViewWithType:(EaseInputTipsViewType)type;
- (instancetype)initWithTipsType:(EaseInputTipsViewType)type;

- (void)refresh;

@end
