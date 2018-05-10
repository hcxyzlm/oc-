//
//  main.m
//  oc消息转发机制
//
//  Created by zhuo on 2018/5/10.
//  Copyright © 2018年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MethodForwardTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        MethodForwardTest *forwardTest = [[MethodForwardTest alloc] init];
        // test方法只有声明，没有实现，在crash之前，会进行消息转发
        // unrecognized selector sent to instance
        [forwardTest test];
    }
    return 0;
}
