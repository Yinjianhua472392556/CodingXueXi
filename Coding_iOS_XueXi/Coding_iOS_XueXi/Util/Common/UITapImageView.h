//
//  UITapImageView.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapImageView : UIImageView
- (void)addTapBlock:(void (^)(id obj))tapAction;

- (void)setImageWithUrl:(NSURL *)imgUrl
       placeholderImage:(UIImage *)placeholderImage
               tapBlock:(void (^)(id obj))tapAction;
@end
