//
//  ViewController.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/3/30.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "RootViewController.h"
#import "MessageForwardViewController.h"
#import "MethodSwizzlingViewController.h"
#import "DicToModelViewController.h"
#import "KVOViewController.h"
static NSString *cellIndify = @"CELL_ID";
@interface RootViewController (){
    NSArray *_titleArray;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = @[@"消息转发",@"方法交换",@"自动归档",@"重写KVO"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIndify];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndify];
    if (indexPath.row < [_titleArray count]) {
        cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *temp = nil;
    if (indexPath.row < [_titleArray count]) {
        temp = [_titleArray objectAtIndex:indexPath.row];
    }
    
    if([temp isEqualToString:@"消息转发"]){
        MessageForwardViewController *mfvc = [[MessageForwardViewController alloc]init];
        mfvc.title = temp;
        [self.navigationController pushViewController:mfvc animated:YES];
    }
    
    if([temp isEqualToString:@"方法交换"]){
        MethodSwizzlingViewController *mfvc = [[MethodSwizzlingViewController alloc]init];
        mfvc.title = temp;
        [self.navigationController pushViewController:mfvc animated:YES];
    }
    
    if([temp isEqualToString:@"自动归档"]){
        DicToModelViewController *mfvc = [[DicToModelViewController alloc]init];
        mfvc.title = temp;
        [self.navigationController pushViewController:mfvc animated:YES];
    }
    
    if([temp isEqualToString:@"重写KVO"]){
        KVOViewController *mfvc = [[KVOViewController alloc]init];
        mfvc.title = temp;
        [self.navigationController pushViewController:mfvc animated:YES];
    }
    
}

@end
