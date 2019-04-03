//
//  MessageForwardViewController.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/1.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "MessageForwardViewController.h"

#import "UserInfo.h"
@interface MessageForwardViewController ()

@end

@implementation MessageForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UserInfo new] sendMessage:@"动态方法添加一"];
    //快速转发
    [[UserInfo new] sendMessageTwo:@"分配接收对象"];
    //慢速转发
     [[UserInfo new] sendMessageThree:@"慢速转发"];
    //未实现
    //[[UserInfo new] sendMessageFour:@"未实现"];
}

@end
