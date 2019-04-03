//
//  UserInfo.m
//  RuntimeDemo
//
//  Created by xiaohui mu on 2019/4/1.
//  Copyright © 2019 xiaohui mu. All rights reserved.
//

#import "UserInfo.h"
#import <objc/runtime.h>
#import "SpareWheel.h"

@implementation UserInfo

void sendMessage(id self, SEL _cmd, NSString *msg){
    NSLog(@"sendMessage:%@",msg);
}


/*第一道处理
 动态添加方法
 1.获取方法明
 2.动态添加一个方法实现
*/
+ (BOOL)resolveInstanceMethod:(SEL)sel{

   NSString *methodName = NSStringFromSelector(sel);

    if ([methodName isEqualToString:@"sendMessage:"]) {
        return  class_addMethod(self, sel, (IMP)sendMessage , "v@:@");
    }

    return NO;
}

/*第二种
 动态接收对象
 1.获取方法明
 2.动态添加备用实现
 */
- (id)forwardingTargetForSelector:(SEL)aSelector{

    NSString *methodName = NSStringFromSelector(aSelector);

    if ([methodName isEqualToString:@"sendMessageTwo:"]) {
        //提供备用接收者
        return [SpareWheel new];
    }
    //转发自己默认调用链
    return [super forwardingTargetForSelector:aSelector];
}


/**第三道方法处理
 慢速转发
 1.获取方法签名
 2.提供转发方法
 */

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"sendMessageThree:"]) {
        return  [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return  [super methodSignatureForSelector:aSelector];
}


- (void)forwardInvocation:(NSInvocation *)anInvocation{
    //获取调用方法
    SEL selector = [anInvocation selector];
    //生成备用接收者
    SpareWheel *tempObj= [SpareWheel new];
    //判断是否实现该方法
    if ([tempObj respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:tempObj];
    }else{
        [super forwardInvocation:anInvocation];
    }
}


/**
 最后一道方法拦截处理(虽然可以执行，但依然会闪退)
 */

- (void)doesNotRecognizeSelector:(SEL)aSelector{
    NSLog(@"doesNotRecognizeSelector");
}

@end
