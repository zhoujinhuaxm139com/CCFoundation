//
//  CCCircleTrack.h
//  CCUIKit
//
//  Created by zjh on 2021/8/23.
//

#import <Foundation/Foundation.h>
#import "CCTrackProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCCircleTrack : NSObject <CCTrackProtocol>

@property (nonatomic,weak) id<CCTrackProtocolDelegate> delegate;

@property (nonatomic,assign) CGRect bounds;

@property (nonatomic,assign) CGFloat ringWidth;

@property (nonatomic,strong) UIColor *color;

@property (nonatomic,assign) CGPoint point;

@property (nonatomic,assign) CGFloat fingerTabWidth;
@end

NS_ASSUME_NONNULL_END
