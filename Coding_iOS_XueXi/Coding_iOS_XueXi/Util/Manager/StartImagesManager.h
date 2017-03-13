//
//  StartImagesManager.h
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Group;
@class StartImage;

@interface StartImagesManager : NSObject
+ (instancetype)shareManager;

- (StartImage *)randomImage;
- (StartImage *)curImage;
- (void)handleStartLink;

- (void)refreshImagesPlist;
- (void)startDownloadImages;

@end



@interface StartImage : NSObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) Group *group;
@property (strong, nonatomic) NSString *fileName, *descriptionStr, *pathDisk;

+ (StartImage *)defautImage;
+ (StartImage *)midAutumnImage;

- (UIImage *)image;
- (void)startDownloadImage;

@end


@interface Group : NSObject
@property (strong, nonatomic) NSString *name, *author, *link;
@end
