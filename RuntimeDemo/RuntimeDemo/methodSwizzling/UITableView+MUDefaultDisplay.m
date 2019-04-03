//
//  UITableView+MUDefaultDisplay.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "UITableView+MUDefaultDisplay.h"
#import <objc/runtime.h>

@implementation UITableView (MUDefaultDisplay)

+ (void)load{
    /**
     确保方法交换只执行一次
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(reloadData));
        Method swizzMethod = class_getInstanceMethod(self, @selector(mu_reloadData));
        method_exchangeImplementations(originalMethod, swizzMethod);
    });
}


-(void)mu_reloadData{
    //交换后调用自己实际是原来的reloadData
    [self mu_reloadData];
    //添加默认判断为空的view
    [self fillDefaultView];
}

-(void)fillDefaultView{

    id<UITableViewDataSource> dataSource = self.dataSource;
    
    NSInteger section = [dataSource respondsToSelector:@selector(numberOfRowsInSection:)] ? [dataSource numberOfSectionsInTableView:self] : 1;
    
    NSInteger rows = 0;
    for (NSInteger i = 0; i<section; i++) {
        rows = [dataSource tableView:self numberOfRowsInSection:section];
    }
    if(!rows){
        self.muDefaultView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.muDefaultView.backgroundColor = [UIColor redColor];
        self.muDefaultView.hidden = NO;
        [self addSubview:self.muDefaultView];
    }else{
        self.muDefaultView.hidden = YES;
    }
}

#pragma mark -- Getter and Setter
/**
 给分类添加属性
 */
-(void)setMuDefaultView:(UIView *)muDefaultView{
    objc_setAssociatedObject(self, "MUDefaultView", muDefaultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)muDefaultView{
  return  objc_getAssociatedObject(self,"MUDefaultView");
}


@end
