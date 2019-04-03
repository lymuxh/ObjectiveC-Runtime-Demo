//
//  KVOUserInfo.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "DicToModelUserInfo.h"
#import <objc/message.h>

@implementation DicToModelUserInfo
/**
 1.KVC
 2.objc_msgsend 测试报错找不到对应方法
函数指针： 返回类型 *函数名 （parame1 ,parem2）
 objc_msgsend(self,SEL,value)
 */
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        for (NSString *key in dic.allKeys) {
            id value = [dic objectForKey:key];
            //KVC实现
            [self setValue:value forKey:key];
            
            //objc_msgSend(id,self,value)实现 执行报错
//            NSString *methodName = [NSString stringWithFormat:@"set%@",key.capitalizedString];
//            SEL sel = NSSelectorFromString(methodName);
//            if(sel){
//                ((void (*) (id,SEL,id))objc_msgSend)(self, sel , value);
//            }
        }
    }
    return self;
}


/**
 简单对象类型处理原理
 获取key-value
 1.KVC实现
 2.objc_msgsend
 key: class_getPropertyList()
 */
-(NSDictionary *)convertModelToDic{
    //
    unsigned  int count =0;

    objc_property_t *propertys = class_copyPropertyList(self.class, &count);
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    if (count != 0) {
        for (int i = 0; i<count; i++) {
            const void *propertyName = property_getName(propertys[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            //KVC 实现
            //[tempDic setObject:[self valueForKey:name] forKey:name];
            //objc_msgSend(id,self,value)实现
            SEL sel = NSSelectorFromString(name);
            if(sel){
              id value =  ((id (*) (id,SEL))objc_msgSend)(self, sel);
                if (value) {
                    tempDic[name] = value;
                }else{
                    tempDic[name] = @"";
                }
            }
        }
        free(propertys);
        return tempDic;
    }
    free(propertys);
    return nil;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}
@end
