//
//  KVOUserInfo.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/3.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "KVOUserInfo.h"
#import <objc/message.h>

@implementation KVOUserInfo

void setterMethod(id self, SEL _cmd,NSString *user){
    /*1.调用父类方法
     2.通知观察者调用(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
    */
    struct objc_super superClass ={
        self,
        class_getSuperclass([self class])
    };
    
    objc_msgSendSuper(&superClass,_cmd,user);
    
    id observer = objc_getAssociatedObject(self,(__bridge const void *)@"objc");
    
    //通知改变
    NSString *methodName = NSStringFromSelector(_cmd);
    NSString *key = getValueKey(methodName);
    //发送消息
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:),key,self,@{key:user},nil);
}

//获取属性名
NSString *getValueKey(NSString * setter){
    NSRange rang = NSMakeRange(3, setter.length-4);
    NSString *key = [setter substringWithRange:rang];
    NSString *letter = [[key substringToIndex:1]lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:letter];
    return key;
}

- (void)mu_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    //创建类-获取kVO类名
    NSString *className = NSStringFromClass([self class]);
    NSString *newClassName = [NSString stringWithFormat:@"CusKVO_%@",className];
    //创建类
    Class customClass =  objc_allocateClassPair([self class], newClassName.UTF8String, 0);
    //注册
    objc_registerClassPair(customClass);
    //修改isa指针,把当前类isa指针新类
    object_setClass(self, customClass);
    //重写set方法
    NSString *methodName = [NSString stringWithFormat:@"set%@:",keyPath.capitalizedString];
    //方法编号
    SEL sel = NSSelectorFromString(methodName);
    //添加方法
    class_addMethod(customClass, sel, (IMP)setterMethod, "v@:@");
    //关联观察者
    objc_setAssociatedObject(self, (__bridge const void *)@"objc", observer, OBJC_ASSOCIATION_ASSIGN);
}

@end
