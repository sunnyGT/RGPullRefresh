//
//  UIView+AHView.h
//  AH
//
//  Created by Robin on 16/9/27.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AHView)

@property (nonatomic ,assign)CGPoint origin;
@property (nonatomic ,assign)CGSize size;

@property (nonatomic ,assign)CGFloat x;
@property (nonatomic ,assign)CGFloat y;

@property (nonatomic ,assign)CGFloat width;
@property (nonatomic ,assign)CGFloat height;

@property (nonatomic ,assign)CGFloat midX;
@property (nonatomic ,assign)CGFloat midY;

@property (nonatomic ,assign)CGFloat maxX;
@property (nonatomic ,assign)CGFloat maxY;


@end
