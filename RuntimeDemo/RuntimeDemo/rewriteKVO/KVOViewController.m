//
//  KVOViewController.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "KVOViewController.h"
#import "KVOUserInfo.h"
#import  <objc/runtime.h>

@interface KVOViewController ()
{
    KVOUserInfo *_user1;
    KVOUserInfo *_user2;
}
@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _user1 = [KVOUserInfo new];
    
    _user2 = [KVOUserInfo new];
   
    _user2.user = @"张三";
    
//    NSLog(@"before:%@----%@",object_getClass(_user1),object_getClass(_user2));
//    NSLog(@"before:%p----%p", [_user1 methodForSelector:@selector(setUser:)],[_user2 methodForSelector:@selector(setUser:)]);
    [_user1 mu_addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionNew context:nil];
//    NSLog(@"after:%@----%@",object_getClass(_user1),object_getClass(_user2));
//    NSLog(@"after:%p----%p",[_user1 methodForSelector:@selector(setUser:)],[_user2 methodForSelector:@selector(setUser:)]);
    
    _user1.user = @"小明";
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"change === %@",change);
    
}

- (void)dealloc{
    //[self removeObserver:self forKeyPath:@"user"];
}

@end
