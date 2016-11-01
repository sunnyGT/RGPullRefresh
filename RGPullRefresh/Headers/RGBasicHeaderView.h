//
//  RGBasicHeaderView.h
//  RGPullRefresh
//
//  Created by Robin on 16/10/26.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RGBasicHeaderView : UIView


- (void)startRefresh;
- (void)finishRefresh;

- (void)setProgress:(CGFloat)present;

@end
