//
//  KVOUserInfo.h
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DicToModelUserInfo : NSObject<NSSecureCoding>
@property(nonatomic,copy) NSString *user;
@property(nonatomic,strong) NSNumber *age;

- (instancetype)initWithDic:(NSDictionary *)dic;
-(NSDictionary *)convertModelToDic;
@end

NS_ASSUME_NONNULL_END
