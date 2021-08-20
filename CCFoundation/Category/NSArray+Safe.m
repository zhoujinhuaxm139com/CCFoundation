//
//  NSArray+Safe.m
//  CCFoundation
//
//  Created by zjh on 2021/7/16.
//

#import "NSArray+Safe.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
@implementation NSArray (Safe)
+(void)load{
//#ifdef DEBUG
//
//#else
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArray0") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(safe_emptyObjectIndex:)];
        [objc_getClass("__NSArrayI") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(safe_arrayObjectIndex:)];
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndex:) swizzledSelector:@selector(safe_mutableObjectIndex:)];
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(insertObject:atIndex:) swizzledSelector:@selector(safe_mutableInsertObject:atIndex:)];
    });
//#endif
    
}

- (id)safe_emptyObjectIndex:(NSInteger)index{
    return nil;
}

- (id)safe_arrayObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self safe_arrayObjectIndex:index];
}

- (id)safe_mutableObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self safe_mutableObjectIndex:index];
}

- (void)safe_mutableInsertObject:(id)object atIndex:(NSUInteger)index{
    if (object) {
        [self safe_mutableInsertObject:object atIndex:index];
    }
}

@end
