//
//  NSObject+ObjectMap.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ObjectMap)
// Universal Method
-(NSDictionary *)propertyDictionary;
-(NSString *)nameOfClass;

// id -> Object
+(id)objectOfClass:(NSString *)object fromJSON:(NSDictionary *)dict;
+(NSMutableArray *)arrayFromJSON:(NSArray *)jsonArray ofObjects:(NSString *)obj;

@end
