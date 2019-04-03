//
//  MethodSwizzlingViewController.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/1.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "MethodSwizzlingViewController.h"
#import "UITableView+MUDefaultDisplay.h"

@interface MethodSwizzlingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray * _tableViewDataArray;
}
@end

@implementation MethodSwizzlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //_tableViewDataArray =@[@"语文",@"数学",@"英语",@"物理",@"化学",@"生物"];
    _tableViewDataArray =@[];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"custom"];
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView reloadData];
    
}

#pragma mark -- tableView delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"custom"];
    cell.textLabel.text = _tableViewDataArray[indexPath.row];
    cell.textLabel.textColor = UIColor.blackColor;
    return cell;
}

@end
