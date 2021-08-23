//
//  CCCircleTrack.m
//  CCUIKit
//
//  Created by zjh on 2021/8/23.
//

#import "CCCircleTrack.h"
@interface CCCircleTrack(){
    CGPoint __center;
    CGFloat __width;
}
@end
@implementation CCCircleTrack
-(void)setColor:(UIColor *)color{
    _color = color;
    [self updatePoint];
}
-(void)setBounds:(CGRect)bounds{
    _bounds = bounds;
    __width = MIN(bounds.size.width, bounds.size.height)/2.0;
    __center = CGPointMake(__width, __width);
    [self updatePoint];
}
-(void)updatePoint{
    CGFloat h,s;
    [_color getHue:&h saturation:&s brightness:nil alpha:nil];
    self.point = [self convertPointFromAngle:h*(M_PI * 2) radius:((__width - (self.fingerTabWidth/2)) * s)];
}
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(id)event{
    CGPoint lastPoint = [touch locationInView:touch.view];
    if ([self.class point:lastPoint inCircleRect:touch.view.bounds]) {
        CGFloat h = [self convertAngleFromPoint:lastPoint]/(M_PI * 2);
        CGFloat s = [self convertRadius:lastPoint]/__width;
        self.color = [UIColor colorWithHue:h saturation:s brightness:1 alpha:1];
        [self updatePoint];
        if ([self.delegate respondsToSelector:@selector(trackingChangePoint:)]) {
            [self.delegate trackingChangePoint:self.point];
        }
        return YES;
    }
    return NO;
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(id)event{
    CGPoint lastPoint = [touch locationInView:touch.view];
    CGFloat h = [self convertAngleFromPoint:lastPoint]/(M_PI * 2);
    CGFloat s = [self convertRadius:lastPoint]/__width;
    self.color = [UIColor colorWithHue:h saturation:s brightness:1 alpha:1];
    [self updatePoint];
    if ([self.delegate respondsToSelector:@selector(trackingChangePoint:)]) {
        [self.delegate trackingChangePoint:self.point];
    }
    return YES;
}
//角度获取圆上的点
-(CGPoint)convertPointFromAngle:(CGFloat)angle radius:(CGFloat)radius{
    CGPoint result;
    result.y = round(__center.y + radius * sin(angle));//-M_PI_2/3
    result.x = round(__center.x + radius * cos(angle));
    return result;
}

-(CGFloat)convertRadius:(CGPoint)point{
    CGFloat dx = point.x - __center.x;
    CGFloat dy = point.y - __center.y;
    CGFloat touchRadius = sqrtf(powf(dx, 2)+powf(dy, 2));
    return (touchRadius > __width) ? __width : touchRadius;
}
-(CGFloat)convertAngleFromPoint:(CGPoint)point{
    CGFloat dx = point.x - __center.x;
    CGFloat dy = point.y - __center.y;
    CGFloat angleRad = atan2f(dy, dx);
    if (angleRad < 0) {
        return angleRad + 2 * M_PI;
    }
    return angleRad;
}
//点在圆的Rect判断
+(BOOL)point:(CGPoint)point inCircleRect:(CGRect)rect{
    CGFloat width = (MIN(rect.size.width, rect.size.height)/2.0);
    CGPoint center = CGPointMake(rect.origin.x + width, rect.origin.y + width);
    double dx = fabs(point.x - center.x);
    double dy = fabs(point.y - center.y);
    double dis = hypot(dx, dy);
    return dis <= width;
}
@end
