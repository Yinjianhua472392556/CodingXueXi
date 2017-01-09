//
//  UIButton+Bootstrap.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NSString+FontAwesome.h>

typedef enum : NSUInteger {
    StrapBootstrapStyle = 0,
    StrapDefaultStyle,
    StrapPrimaryStyle,
    StrapSuccessStyle,
    StrapInfoStyle,
    StrapWarningStyle,
    StrapDangerStyle
} StrapButtonStyle;

@interface UIButton (Bootstrap)

- (void)bootstrapStyle;
- (void)defaultStyle;
-(void)primaryStyle;
-(void)successStyle;
-(void)infoStyle;
-(void)warningStyle;
-(void)dangerStyle;
- (UIImage *) buttonImageFromColor:(UIColor *)color ;
+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style andTitle:(NSString *)title andFrame:(CGRect)rect target:(id)target action:(SEL)selector;

@end
