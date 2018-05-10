//
//  ForwardReplaceImp.h
//  oc消息转发机制
//
//  Created by zhuo on 2018/5/10.
//  Copyright © 2018年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 这个类，配合MethodForwardTest使用，他实现了test方法，MethodForwardTest会将方法转发到ForwardReplaceImp test上
 */
@interface ForwardReplaceImp : NSObject

- (void)test;

@end
