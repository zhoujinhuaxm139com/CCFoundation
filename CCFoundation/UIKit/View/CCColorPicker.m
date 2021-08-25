//
//  CCColorPicker.m
//  CCUIKit
//
//  Created by zjh on 2021/8/23.
//

#import "CCColorPicker.h"
#import "CCGradientRingLayer.h"
#import "CCCircleTrack.h"
#import "CCRingTrack.h"
@interface CCColorPicker()<CCTrackProtocolDelegate>{
    CCColorPickerType __type;
}
@property (nonatomic,strong) CCGradientRingLayer *ringLayer;
@property (nonatomic,strong) UIImageView *fingerTab;
@property (nonatomic,strong) id<CCTrackProtocol> trackProtocol;
@end
@implementation CCColorPicker
-(id)initWithType:(CCColorPickerType)type{
    if (self = [super init]) {
        __type = type;
        [self __initUI];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.ringLayer];
        self.ringWidth = 50;//ring default
    }
    return self;
}
-(void)__initUI{
    [self addSubview:self.fingerTab];
    if (__type == CCColorPickerTypeCircle) {
        self.trackProtocol = [[CCCircleTrack alloc] init];
    }else{
        self.trackProtocol = [[CCRingTrack alloc] init];
    }
    self.trackProtocol.fingerTabWidth = 40;
    self.trackProtocol.color = [UIColor colorWithHue:0 saturation:1 brightness:1 alpha:1];
    self.trackProtocol.delegate = self;
}
-(void)setRingWidth:(CGFloat)ringWidth{
    _ringWidth = ringWidth;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.trackProtocol.ringWidth = self.ringWidth;
    self.trackProtocol.bounds = self.bounds;
    
    [self updateRingWidth];
    
    self.ringLayer.frame = self.bounds;
    self.fingerTab.center = self.trackProtocol.point;
}
-(void)setColor:(UIColor *)color{
    self.trackProtocol.color = color;
    self.fingerTab.center = self.trackProtocol.point;
}
-(UIColor *)color{
    return self.trackProtocol.color;
}
-(void)updateRingWidth{
    if (__type == CCColorPickerTypeCircle) {
        self.ringLayer.width = CGRectGetWidth(self.bounds)/2.0;
        self.ringLayer.radialGradient = YES;
    }else{
        self.ringLayer.width = self.ringWidth;
        self.ringLayer.radialGradient = NO;
    }
}
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    return [self.trackProtocol beginTrackingWithTouch:touch withEvent:event];
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    return [self.trackProtocol continueTrackingWithTouch:touch withEvent:event];
}
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
    
}
-(void)trackingChangePoint:(CGPoint)point{
    self.fingerTab.center = point;
}
-(CCGradientRingLayer *)ringLayer{
    if (!_ringLayer) {
        _ringLayer = [CCGradientRingLayer layer];
    }
    return _ringLayer;
}
-(UIImageView *)fingerTab{
    if (!_fingerTab) {
        _fingerTab = [[UIImageView alloc] init];
        _fingerTab.backgroundColor = UIColor.whiteColor;
        _fingerTab.frame = CGRectMake(0, 0, 40, 40);
        _fingerTab.layer.cornerRadius = 20;
    }
    return _fingerTab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
