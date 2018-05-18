//
//  DynamicMethodDictory.m
//  oc消息转发机制
//
//  Created by zhuo on 2018/5/18.
//  Copyright © 2018年 zhuo. All rights reserved.
//

#import "DynamicMethodDictory.h"
#import <objc/runtime.h>

@interface DynamicMethodDictory ()

@property (nonatomic, strong) NSMutableDictionary *backMutableDic; //字典存储

@end

@implementation DynamicMethodDictory
@dynamic string,number;   // string，number的存取方法不由系统实现，所以当调用setter/getter，会发生crash，我们在动态解析方法中来处理方法，避免发生crash

- (instancetype)init {
    if (self = [super init]) {
        
        _backMutableDic = [[NSMutableDictionary alloc] init];
    };
    
    return self;
}

// 动态解析方法

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *methodString = NSStringFromSelector(sel);
    if ([methodString hasPrefix:@"set"]) {
        // setting方法
        class_addMethod(self, sel, (IMP)dictorySetter, "v@:@");
        return YES;
    }else  {
        class_addMethod(self, sel, (IMP)dictoryGetter, "@@:");
        return YES;
    }
}

void dictorySetter(id self, SEL _cmd, id value) {
    
    DynamicMethodDictory *weakSelf = (DynamicMethodDictory *)self;
    NSDictionary *dict = weakSelf.backMutableDic;
    NSString *selectString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectString mutableCopy];
    [key deleteCharactersInRange: NSMakeRange(key.length-1, 1)];
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    [dict setValue:value forKey:[key lowercaseString]];
}

id dictoryGetter(id self, SEL _cmd) {
    
    DynamicMethodDictory *weakSelf = (DynamicMethodDictory *)self;
    NSDictionary *dict = weakSelf.backMutableDic;
    NSString *key = NSStringFromSelector(_cmd);
    
    return  dict[key];
}

@end
