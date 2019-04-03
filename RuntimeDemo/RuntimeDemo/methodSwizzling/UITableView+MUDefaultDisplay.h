//
//  UITableView+MUDefaultDisplay.h
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (MUDefaultDisplay)
-(UIView *)muDefaultView;
-(void)mu_reloadData;
@end

NS_ASSUME_NONNULL_END
