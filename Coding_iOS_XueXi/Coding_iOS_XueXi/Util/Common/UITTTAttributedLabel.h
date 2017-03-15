//
//  UITTTAttributedLabel.h
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <TTTAttributedLabel/TTTAttributedLabel.h>

typedef void(^UITTTLabelTapBlock)(id aObj);

@interface UITTTAttributedLabel : TTTAttributedLabel
- (void)addLongPressForCopy;
- (void)addLongPressForCopyWithBGColor:(UIColor *)color;
- (void)addTapBlock:(UITTTLabelTapBlock)block;
-(void)addDeleteBlock:(UITTTLabelTapBlock)block;

@end
