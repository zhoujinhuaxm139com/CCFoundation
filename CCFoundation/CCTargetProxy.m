//
//  CCTagetProxy.m
//  HelloWord
//
//  Created by zjh on 2021/7/15.
//  Copyright © 2021 CChip. All rights reserved.
//

#import "CCTargetProxy.h"
@interface CCTargetProxy()
@property (nonatomic,weak,readonly) id target;
@end
@implementation CCTargetProxy
-(instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}
+(instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}
- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if([self.target respondsToSelector:sel]){
        [invocation invokeWithTarget:self.target];//转发
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSAssert(self.target, @"目前对象失效, NSTimer必须注销");
    return [self.target methodSignatureForSelector:sel];//重新签名
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self.target respondsToSelector:aSelector];
}
@end
