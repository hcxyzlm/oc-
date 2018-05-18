//
//  DynamicMethodDictory.h
//  oc消息转发机制
//
//  Created by zhuo on 2018/5/18.
//  Copyright © 2018年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>

// 动态添加setter/getter类，要配合@dynamic属性来使用

@interface DynamicMethodDictory : NSObject

@property (nonatomic, strong) NSString *string;

@property (nonatomic, strong) NSNumber *number;


@end
