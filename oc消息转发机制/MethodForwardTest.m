//
//  MethodForwardTest.m
//  oc消息转发机制
//
//  Created by zhuo on 2018/5/10.
//  Copyright © 2018年 zhuo. All rights reserved.
//

#import "MethodForwardTest.h"
#import <objc/runtime.h>
#import "ForwardReplaceImp.h"

/*
 这个类来演示oc类对消息进行转发的过程，在crash之前，会有三次机会进行解析，
 依次执行顺序是动态方法解析--》快速消息转发--》标准消息转发
 注释第一次机会相干代码，就进入第二次机会，所有相关机会代码，就会报错
 **/


void dynamicMethod (){
    NSLog(@"第一次首先尝试添加动态方法");
}


@implementation MethodForwardTest

/*
 第一次机会，添加动态方法
 **/


//id dynamicMethod (id self, IMP _cmd) {
//
//    NSLog(@"第一次首先尝试添加动态方法");
//    return @"第一次首先尝试添加动态方法";
//}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(test)) {
        class_addMethod([self class], sel, (IMP)dynamicMethod, "v@:");
        return YES;
    }

    return [super resolveInstanceMethod:sel];

}


/*
 第二次，快速消息转发，将消息转发到
 */

//- (id)forwardingTargetForSelector:(SEL)aSelector{
//
//    NSString *methodName = NSStringFromSelector(aSelector);
//
//    if ([methodName isEqualToString:@"test"]) {
//
//        ForwardReplaceImp *replace = [[ForwardReplaceImp alloc] init];
//        if ([replace respondsToSelector:@selector(test)]) {
//            return replace;
//        }
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}


/*
 最后一次机会，完整的方法转发
**/

- (void)otherTest {
    NSLog(@"另一个test方法");
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSLog(@"%s", __func__);
    
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    if (!signature) { // 如果该方法无法处理
        if ([self respondsToSelector:@selector(otherTest)]) {
            signature = [MethodForwardTest instanceMethodSignatureForSelector:@selector(otherTest)];
        }
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s", __func__);
    [anInvocation setSelector:@selector(otherTest)];// 选择哪个方法
    [anInvocation setTarget:self]; // 选择哪个实例，这里是self的antherTest方法
    [anInvocation invoke];
}
@end
