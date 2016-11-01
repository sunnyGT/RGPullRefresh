//
//  AHPullRefreshHeaderView.m
//  AH
//
//  Created by Robin on 16/10/19.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import "RGDiamondsHeaderView.h"
#import "UIView+AHView.h"

#define ITEM_COUNT 7
#define ITEM_GAP 0.5
@implementation RGDiamondsHeaderView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.layer.affineTransform = CGAffineTransformMakeRotation(M_PI_4);
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.diamondesShapeLayer];
    [self addShapeLayers];

}

- (void)startRefresh{
    
    [self finishRefresh];
    _diamondesShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    [self addItemAnimation];
}

- (void)finishRefresh{

    _diamondesShapeLayer.strokeColor = [UIColor blackColor].CGColor;
    [self.diamondesShapeLayer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeAllAnimations];
    }];
}

- (void)setProgress:(CGFloat)present{
    
    self.diamondesShapeLayer.strokeStart = 0.f;
    self.diamondesShapeLayer.strokeEnd = present;
}

- (UIBezierPath *)lineBezierPath{
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointZero];
    
    [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    
    [bezier addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
    
    [bezier addLineToPoint:CGPointMake(0, CGRectGetWidth(self.frame))];
    [bezier addLineToPoint:CGPointZero];
    
    [bezier stroke];
    return bezier;
}

- (CAShapeLayer *)diamondesShapeLayer{
    if (!_diamondesShapeLayer) {
        _diamondesShapeLayer = [CAShapeLayer layer];
        _diamondesShapeLayer.path = [self lineBezierPath].CGPath;
        _diamondesShapeLayer.strokeColor = [UIColor blackColor].CGColor;
        _diamondesShapeLayer.lineWidth = 0.5f;
        _diamondesShapeLayer.fillColor = [UIColor whiteColor].CGColor;
        ;
    }
    return _diamondesShapeLayer;
}



#pragma mark - Animation

- (CABasicAnimation *)scaleAnimation{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.duration = 2.5;
    scale.autoreverses = YES;
    scale.repeatCount = ITEM_COUNT * ITEM_COUNT;
    return scale;
}

- (CABasicAnimation *)alphaAnimation{
    
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(0);
    alpha.toValue = @(1.0);
    alpha.duration = 2.5;
    alpha.autoreverses = YES;
    alpha.repeatCount = MAXFLOAT;
    return alpha;
}

- (CABasicAnimation *)alphaAnimation:(CGFloat)fromValue{
    
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(fromValue);
    alpha.toValue = @(1.0 - fromValue);
    alpha.duration = 0.8;
    alpha.autoreverses = YES;
    alpha.repeatCount = MAXFLOAT;
    return alpha;
}



- (void)addShapeLayers{
    CGFloat itemWidth = (self.width - (ITEM_COUNT - 1)*ITEM_GAP)/ITEM_COUNT;
    CGFloat itemHeight = (self.height - (ITEM_COUNT - 1)*ITEM_GAP)/ITEM_COUNT;
    for (NSInteger idx_y = 0 ; idx_y< ITEM_COUNT; idx_y++) {
        for (NSInteger idx_x = 0; idx_x < ITEM_COUNT; idx_x ++ ) {
            @autoreleasepool {
                CAShapeLayer *itemLayer = [CAShapeLayer layer];
                itemLayer.strokeColor = [UIColor clearColor].CGColor;
                itemLayer.fillColor = [UIColor blackColor].CGColor;
                itemLayer.opacity = 0.f;
                CGRect itemRect = CGRectMake((itemWidth + ITEM_GAP) * idx_x , (itemHeight + ITEM_GAP) * idx_y, itemWidth, itemHeight);
                UIBezierPath *itemPath = [UIBezierPath bezierPathWithRect:itemRect];
                itemLayer.path = itemPath.CGPath;
                [self.diamondesShapeLayer addSublayer:itemLayer];
                
            }
        }
    }
}

- (void)addItemAnimation{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger idx = 0 ; idx < ITEM_COUNT  ; idx++) {
        NSMutableArray *num = [NSMutableArray array];
        
        for (NSUInteger inIdx = 0; inIdx <= idx; inIdx ++) {
            [num addObject:@(idx + (ITEM_COUNT - 1)  * inIdx)];
        }
        [arr addObject:num];
    }
    
    for (NSInteger idx = ITEM_COUNT * 2 - 1 ; idx < powl(ITEM_COUNT, 2); idx += ITEM_COUNT) {
        
        NSMutableArray *num = [NSMutableArray array];
        for (NSUInteger inIdx = 0; inIdx < ITEM_COUNT - (idx / ITEM_COUNT); inIdx++) {
            [num addObject:@(idx + (ITEM_COUNT -1)  * inIdx)];
        }
        [arr addObject:num];
    }
    
    for (NSInteger num = 0; num<arr.count; num++) {
        for (NSNumber * idx in arr[num]) {
            [self.diamondesShapeLayer.sublayers[[idx integerValue]] addAnimation:[self alphaAnimation:num/(ITEM_COUNT * 2.0)] forKey:@"opsition"];
        }
    }
}

- (CAShapeLayer *)itemShape{
    
    CGFloat itemHeight = (self.height - (ITEM_COUNT - 1)*ITEM_GAP)/ITEM_COUNT;
    CAShapeLayer *itemShape = [CAShapeLayer layer];
    itemShape.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, itemHeight, itemHeight)].CGPath;
    itemShape.fillColor = [UIColor blackColor].CGColor;
    [itemShape addAnimation:[self alphaAnimation]  forKey:@"alpha"];
    return itemShape;
}

- (void)itemAnimaiton:(NSArray *)layer{
    for (NSNumber * idx in layer[0]) {
        [[self.gradientLayer.sublayers objectAtIndex:[idx integerValue]] addAnimation:[self alphaAnimation:[layer[1] floatValue]] forKey:@"opsition"];
    }
    
    
}



@end
