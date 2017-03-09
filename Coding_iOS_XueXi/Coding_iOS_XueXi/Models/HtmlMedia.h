//
//  HtmlMedia.h
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <TFHpple.h>

typedef enum : NSUInteger {
    HtmlMediaItemType_Image = 0,
    HtmlMediaItemType_Code,
    HtmlMediaItemType_EmotionEmoji,
    HtmlMediaItemType_EmotionMonkey,
    HtmlMediaItemType_ATUser,
    HtmlMediaItemType_AutoLink,
    HtmlMediaItemType_CustomLink,
    HtmlMediaItemType_Math
} HtmlMediaItemType;


typedef enum : NSUInteger {
    MediaShowTypeNone = 1,
    MediaShowTypeCode = 2,
    MediaShowTypeImage = 3,
    MediaShowTypeMonkey = 5,
    MediaShowTypeImageAndMonkey = 15,
    MediaShowTypeAll = 30
} MediaShowType;


@class HtmlMediaItem;

@interface HtmlMedia : NSObject
@property (nonatomic, copy, readwrite) NSString *contentOrigional;
@property (readwrite, nonatomic, strong) NSMutableString *contentDisplay;
@property (readwrite, nonatomic, strong) NSMutableArray *mediaItems;
@property (strong, nonatomic) NSArray *imageItems;

- (void)removeItem:(HtmlMediaItem *)item;
- (BOOL)needToShowDetail;

+ (instancetype)htmlMediaWithString:(NSString *)htmlString showType:(MediaShowType)showType;
- (instancetype)initWithString:(NSString *)htmlString showType:(MediaShowType)showType;

//在curString的末尾添加一个media元素
+ (void)addMediaItem:(HtmlMediaItem *)curItem toString:(NSMutableString *)curString andMediaItems:(NSMutableArray *)itemList;
+ (void)addLinkStr:(NSString *)linkStr type:(HtmlMediaItemType)type toString:(NSMutableString *)curString andMediaItems:(NSMutableArray *)itemList;
+ (void)addMediaItemUser:(User *)curUser toString:(NSMutableString *)curString andMediaItems:(NSMutableArray *)itemList;
@end


@interface HtmlMediaItem : NSObject
@property (nonatomic, assign) HtmlMediaItemType type;
@property (nonatomic, assign) MediaShowType showType;
@property (readwrite, nonatomic, strong) NSString *src, *title, *href, *name, *code, *linkStr;
@property (nonatomic, assign) NSRange range;

+ (instancetype)htmlMediaItemWithType:(HtmlMediaItemType)type;
+ (instancetype)htmlMediaItemWithTypeATUser:(User *)curUser mediaRange:(NSRange)curRange;


- (NSString *)displayStr;
- (BOOL)isGif;
@end
