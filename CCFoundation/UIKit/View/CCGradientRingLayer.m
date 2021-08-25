//
//  CCGradientRingView.m
//  CCUIKit
//
//  Created by zjh on 2021/8/20.
//

#import "CCGradientRingLayer.h"
@interface CCGradientRingLayer(){
    CGPoint __center;
    CGFloat __width;
}
@end

@implementation CCGradientRingLayer
-(id)init{
    if (self = [super init]) {
        self.contentsScale = UIScreen.mainScreen.scale;
    }
    return self;
}
-(void)setWidth:(CGFloat)width{
    _width = width;
    [self setNeedsDisplay];
}

-(void)layoutSublayers{
    [super layoutSublayers];
    __center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    __width = MIN(self.frame.size.width, self.frame.size.height)/2;
    self.contentsScale = UIScreen.mainScreen.scale;
    [self setNeedsDisplay];
}

-(void)drawInContext:(CGContextRef)ctx{
    [super drawInContext:ctx];
    NSInteger count = 360;
    CGContextClearRect(ctx, self.frame);
    for (int i = 0;i < count;i++) {
        CGMutablePathRef cgPath = CGPathCreateMutable();
        CGPathAddArc(cgPath, NULL, __center.x, __center.y, __width, i*M_PI/180, (i+1)*M_PI/180, NO);
        CGPathAddArc(cgPath, NULL, __center.x, __center.y, __width - _width, (i+1)*M_PI/180, i*M_PI/180, YES);
        CGPathCloseSubpath(cgPath);
        UIColor *color = [UIColor colorWithHue:1/360.0*i saturation:1 brightness:1 alpha:1];
        CGContextSetFillColorWithColor(ctx, color.CGColor);
        CGContextSetStrokeColorWithColor(ctx, color.CGColor);
        CGContextAddPath(ctx, cgPath);
        CGContextDrawPath(ctx, kCGPathFillStroke);
    }
    if (self.radialGradient) {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:__center radius:__width startAngle:0 endAngle:2*M_PI clockwise:YES];
        [self drawRadialGradient:ctx path:[path CGPath] startColor:[UIColor whiteColor].CGColor endColor:UIColor.clearColor.CGColor];
    }
}

//径向渐变
- (void)drawRadialGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 0.8};
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGFloat radius = MIN(pathRect.size.width / 2.0, pathRect.size.height / 2.0) * sqrt(2);
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    CGContextDrawRadialGradient(context, gradient, __center, 0, __center, radius, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
