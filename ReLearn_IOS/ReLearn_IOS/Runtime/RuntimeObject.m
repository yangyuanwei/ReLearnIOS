//
//  RuntimeObject.m
//  ReLearn_IOS
//
//  Created by yyw on 2024/2/4.
//

#import "RuntimeObject.h"
#import <objc/runtime.h>

@implementation RuntimeObject

+(void)load{
    
    Method m1 = class_getClassMethod(self, @selector(test));
    Method m2 = class_getClassMethod(self, @selector(otherTest));
    method_exchangeImplementations(m1, m2);
}



- (void)otherTest{
    [self test];
    NSLog(@"otherTest");
}

void dynamicMethodIMP(id self, SEL _cmd){
    NSLog(@"成功添加了动态方法:%@",self);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(test)) {
        NSLog(@"resolveInstanceMethod:");
        class_addMethod([self class], sel, (IMP) dynamicMethodIMP, "v@:");
           return NO;
        return NO;
    }else{
        return  [super resolveInstanceMethod:sel];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"forwardingTargetForSelector:");
    return nil;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(test)) {
        NSLog(@"methodSignatureForSelector:");
        //v 代表返回值void类型的
        //@ 代表第一个参数类型id, 即self
        //: 代表第二个参数是SEL类型， 即@selector(test)
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }else{
        return [NSMethodSignature methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"forwardInvocation:");
}
@end
