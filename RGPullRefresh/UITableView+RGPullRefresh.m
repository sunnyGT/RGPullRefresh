//
//  UITableView+RGPullRefresh.m
//  RGPullRefresh
//
//  Created by Robin on 16/10/26.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import "UITableView+RGPullRefresh.h"
#import "RGPullRefreshHeader.h"
#import <objc/runtime.h>

static const char RefreshOverKey;
static const char RGPullRefreshHeaderKey;

@implementation UITableView (RGPullRefresh)

- (void)setComplete:(Complete)complete{
    
    return objc_setAssociatedObject(self, &RefreshOverKey, complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (Complete)complete{
    return objc_getAssociatedObject(self, &RefreshOverKey);
}

- (RGPullRefreshHeader *)RGPullRefreshHeader{
    return objc_getAssociatedObject(self, &RGPullRefreshHeaderKey);
}

- (void)setRGPullRefreshHeader:(RGPullRefreshHeader *)RGPullRefreshHeader{
    return objc_setAssociatedObject(self, &RGPullRefreshHeaderKey, RGPullRefreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)RGPullRefreshHeader:(RGPullRefreshHeader *)header complete:(void (^)())complete{
    
    self.RGPullRefreshHeader = header;
    self.RGPullRefreshHeader.complete = complete;
    [self.RGPullRefreshHeader setTargetTable:self];
}
@end
