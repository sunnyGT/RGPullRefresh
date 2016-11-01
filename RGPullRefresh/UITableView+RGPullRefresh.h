//
//  UITableView+RGPullRefresh.h
//  RGPullRefresh
//
//  Created by Robin on 16/10/26.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGPullRefreshHeader.h"


@interface UITableView (RGPullRefresh)

@property (nonatomic ,copy)Complete complete;
@property (nonatomic ,strong)RGPullRefreshHeader *RGPullRefreshHeader;

- (void)RGPullRefreshHeader:(RGPullRefreshHeader *)header complete:(void(^)())complete;


@end
