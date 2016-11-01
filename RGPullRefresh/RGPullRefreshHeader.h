//
//  RGPullRefreshHeader.h
//  RGPullRefresh
//
//  Created by Robin on 16/10/25.
//  Copyright © 2016年 Robin. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, HeaderType) {
    Diamondes = 1,
    Circle,
    Default
};

@class UITableView;

typedef void(^Complete)();

@interface RGPullRefreshHeader : NSObject

@property (nonatomic ,copy)Complete complete;
@property (nonatomic ,assign)HeaderType type;

+ (RGPullRefreshHeader *)RGPullRefreshHeaderWithType:(HeaderType)type;
- (void)setTargetTable:(UITableView *)targetTable;



@end
