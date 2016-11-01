//
//  AHPullRefreshHeaderView.h
//  AH
//
//  Created by Robin on 16/10/19.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import "RGBasicHeaderView.h"

@interface RGDiamondsHeaderView : RGBasicHeaderView

@property (nonatomic ,strong)CAGradientLayer *gradientLayer;
@property (nonatomic ,strong)CAShapeLayer *maskLayer;
@property (nonatomic ,strong)CAReplicatorLayer *replicatorX;
@property (nonatomic ,strong)CAReplicatorLayer *replicatorY;
@property (nonatomic ,strong)CAShapeLayer *diamondesShapeLayer;

@end
