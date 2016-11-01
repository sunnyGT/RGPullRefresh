//
//  RGPullRefreshHeader.m
//  RGPullRefresh
//
//  Created by Robin on 16/10/25.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import "RGPullRefreshHeader.h"

#import "RGDiamondsHeaderView.h"
#import "RGCircleHeaderView.h"

typedef NS_ENUM(NSUInteger, HeaderState) {
    Normal = 1,
    Pulling,//下拉状态
    Refreshing,
};
#define MAX_HEIGHT 75.f
#define TABLE_INSET_TOP 64.f
@interface RGPullRefreshHeader ()

@property (nonatomic ,assign)UIEdgeInsets targetTableContentInset;
@property (nonatomic ,assign)CGFloat present;
@property (nonatomic ,strong)UIView *containView;
@property (nonatomic ,strong)RGBasicHeaderView *header;
@property (nonatomic ,strong)UITableView *targetTable;
@property (nonatomic ,assign)HeaderState state;
@end

@implementation RGPullRefreshHeader

+ (RGPullRefreshHeader *)RGPullRefreshHeaderWithType:(HeaderType)type{
    
    RGPullRefreshHeader *instance = [[self alloc] init];
    instance.type = type;
    return instance;
}

- (UIView *)containView{
    if (!_containView) {
        _containView = [[UIView alloc] initWithFrame:CGRectMake(0, TABLE_INSET_TOP, CGRectGetWidth(self.targetTable.frame), self.targetTable.frame.size.height)];
        _containView.backgroundColor = [UIColor whiteColor];
    }
    return _containView;
}

- (void)setType:(HeaderType)type{
    if (_type == type) return;
    switch (type) {
        case Diamondes:
            
            self.header = [[RGDiamondsHeaderView alloc] initWithFrame:CGRectMake((CGRectGetWidth([[UIScreen mainScreen] bounds]) - 16)/2, 70, 16, 16)];
            
            break;
            
        case Circle:
            
            self.header = [[RGCircleHeaderView alloc] initWithFrame:CGRectMake((CGRectGetWidth([[UIScreen mainScreen] bounds]) - 32)/2, 70, 32, 32)];
            
            break;
            
        default:
            break;
    }
    [self.containView addSubview:_header];

}

- (void)setTargetTable:(UITableView *)targetTable{
    
    [targetTable addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _targetTable = targetTable;
    self.targetTableContentInset  = targetTable.contentInset;
    _targetTable.backgroundView = self.containView;
    
}


    

- (void)setState:(HeaderState)state{

    if (_state == state) return;
    
    switch (state) {
        case Pulling:{
            //绘制

                
        }
            break;
        case Refreshing:
            //动画
        {
            [self.header startRefresh];
            [UIView animateWithDuration:0.25 animations:^{
                
                UIEdgeInsets inset = _targetTable.contentInset;
                inset.top = TABLE_INSET_TOP + MAX_HEIGHT;
                _targetTable.contentInset = inset;

            }];
#pragma mark -Test
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setState:Normal];
                [UIView animateWithDuration:0.25 animations:^{
                    UIEdgeInsets inset = _targetTable.contentInset;
                    inset.top = TABLE_INSET_TOP;
                    _targetTable.contentInset = inset;
//                    _targetTable.contentOffset = CGPointMake(0, -TABLE_INSET_TOP);
                }];
            
            });
           
        }
            
            break; 
        case Normal:
            //绘制 删除
            
            [self.header finishRefresh];
            self.complete();
            
            break;
            
        default:
            break;
    }
    _state = state;

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGFloat offsetY = -self.targetTable.contentOffset.y - 64;
    if (offsetY < 0 || self.state == Refreshing) return;
    //判断是否下拉
    if (self.targetTable.isDragging) {
        //pulling
        [self setState:Pulling];
        [self offsetPresent:offsetY];
        [self.header setProgress:self.present];
        
    }else{
        if (self.state == Pulling && offsetY >= MAX_HEIGHT) {
           [self setState:Refreshing];
            return;
        }
        [self setState:Normal];
        [self offsetPresent:offsetY];
        [self.header setProgress:self.present];
        
    }
    
}

- (void)offsetPresent:(CGFloat)offsetY{

    CGFloat present = fabs((offsetY) / MAX_HEIGHT);
    self.present = MIN(present, 1.f);
}


- (void)dealloc{
    [self.targetTable removeObserver:self forKeyPath:@"contentOffset"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
