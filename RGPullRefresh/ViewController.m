//
//  ViewController.m
//  RGPullRefresh
//
//  Created by Robin on 16/10/25.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import "ViewController.h"
#import "RGPullRefreshHeader.h"
#import "RGDiamondsHeaderView.h"
#import "UITableView+RGPullRefresh.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)RGPullRefreshHeader *header;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 44.f;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.header = [RGPullRefreshHeader RGPullRefreshHeaderWithType:(self.type + 1)];
    [self.tableView RGPullRefreshHeader:_header complete:^{
        NSLog(@"OK");
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
