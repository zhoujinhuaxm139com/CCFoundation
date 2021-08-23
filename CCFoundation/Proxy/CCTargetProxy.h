//
//  CCTagetProxy.h
//  HelloWord
//
//  Created by zjh on 2021/7/15.
//  Copyright © 2021 CChip. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCTargetProxy : NSProxy
-(instancetype)initWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
