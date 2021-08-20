//
//  NSDictionary+Safe.m
//  CCFoundation
//
//  Created by zjh on 2021/8/19.
//  Copyright © 2021 zjh. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
@implementation NSDictionary(Safe)
+(void)load{
//#ifdef DEBUG
//
//#else
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSDictionaryM") swizzleMethod:@selector(setObject:forKey:) swizzledSelector:@selector(safe_setObject:forKey:)];
    });
//#endif
}

- (void)safe_setObject:(id)anyObj forKey:(id<NSCopying>)key{
    id copyKey = key;
    if (copyKey) {
        [self safe_setObject:anyObj forKey:copyKey];
    }
}
@end
