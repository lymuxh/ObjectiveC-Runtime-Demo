//
//  KVOUserInfo.h
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVOUserInfo : NSObject
@property(nonatomic,copy) NSString *user;
@property(nonatomic,strong) NSNumber *age;
- (void)mu_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
@end

NS_ASSUME_NONNULL_END
