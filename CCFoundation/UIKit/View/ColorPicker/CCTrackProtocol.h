//
//  CCTrackProtocol.h
//  CCUIKit
//
//  Created by zjh on 2021/8/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CCTrackProtocolDelegate <NSObject>
-(void)trackingChangePoint:(CGPoint)point;//finger point change
@end

@protocol CCTrackProtocol <NSObject>
@property (nonatomic,weak) id<CCTrackProtocolDelegate> delegate;

@property (nonatomic,assign) CGRect bounds;//control bounds 控制器bounds

@property (nonatomic,assign) CGFloat ringWidth;//ring width 色盘宽度

@property (nonatomic,strong) UIColor *color;//control color

@property (nonatomic,assign) CGPoint point;//finger point

@property (nonatomic,assign) CGFloat fingerTabWidth; //fingertab width

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event;

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event;


@end

NS_ASSUME_NONNULL_END
