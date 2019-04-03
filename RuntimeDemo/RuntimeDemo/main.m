//
//  main.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/3/30.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/**注释**/

__attribute__((constructor(103))) static void beforeMain3() {
    NSLog(@"before main 3");
}

__attribute__((constructor(101))) static void beforeMain1() {
    NSLog(@"before main 1");
}

__attribute__((constructor(102))) static void beforeMain2() {
    NSLog(@"before main 2");
}


__attribute__((destructor(103))) static void afterMain3() {
    NSLog(@"after main 3");
}

__attribute__((destructor(101))) static void afterMain1() {
    NSLog(@"after main 1");
}

__attribute__((destructor(102))) static void afterMain2() {
    NSLog(@"after main 2");
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"execute main");
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    return 0;
}
