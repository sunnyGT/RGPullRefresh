//
//  RGCircleHeaderView.m
//  RGPullRefresh
//
//  Created by Robin on 16/10/26.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import "RGCircleHeaderView.h"

#define DEGREES_TO_RADIANS(x) ((x)/180.0*M_PI)
#define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0)

const CGFloat radius = 18.f;

@interface RGCircleHeaderView ()<CAAnimationDelegate>

@end
@implementation RGCircleHeaderView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self.layer addSublayer:self.cricleLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.cricleLayer];
        self.layer.affineTransform = CGAffineTransformMakeRotation(-M_PI_2);
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
    return self;
    
}

- (CAShapeLayer *)cricleLayer{
    if (!_cricleLayer) {
        _cricleLayer = [CAShapeLayer layer];
        _cricleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        _cricleLayer.fillColor = [UIColor clearColor].CGColor;
        _cricleLayer.strokeColor = [UIColor blackColor].CGColor;
    }
    return _cricleLayer;
}

- (void)setProgress:(CGFloat)present{
    self.cricleLayer.strokeStart = 0;
    self.cricleLayer.strokeEnd = MIN(present, 0.9);
}

- (void)startRefresh{
    
    CABasicAnimation *rotationAniamtion = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAniamtion.toValue = @(DEGREES_TO_RADIANS(270));
    rotationAniamtion.repeatCount = MAXFLOAT;
    rotationAniamtion.duration = 1.5;
    rotationAniamtion.delegate = self;
    [self.layer addAnimation:rotationAniamtion forKey:@"rotationZ"];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"calayer%@ , shapeLayer:%@",self.layer.presentationLayer, NSStringFromCGAffineTransform(self.cricleLayer.presentationLayer.affineTransform));
    
}


- (void)finishRefresh{
    
    [self.layer removeAllAnimations];
    self.cricleLayer.strokeEnd = 0.f;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
