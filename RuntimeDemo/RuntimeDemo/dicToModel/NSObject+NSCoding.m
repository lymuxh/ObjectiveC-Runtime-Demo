//
//  NSObject+NSCoding.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "NSObject+NSCoding.h"
#import <objc/runtime.h>

@implementation NSObject (NSCoding)

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [self init];
    if (self) {
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for(int i = 0;i < count; i++){
            const void * property =  property_getName(properties[i]);
            NSString *propertyName = [NSString stringWithUTF8String:property];
            [self setValue:[aDecoder decodeObjectForKey:propertyName] forKey:propertyName];
        }
        free(properties);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0;i < count; i++){
        const void * property =  property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:property];
        [aCoder encodeObject:[self valueForKey:propertyName] forKey:propertyName];
    }
    free(properties);
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
