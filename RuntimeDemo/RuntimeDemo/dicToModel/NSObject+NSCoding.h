//
//  NSObject+NSCoding.h
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NSCoding)
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;
@end

NS_ASSUME_NONNULL_END
