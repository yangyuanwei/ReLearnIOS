//
//  ReusePoolTable.m
//  ReLearn_IOS
//
//  Created by yyw on 2024/1/31.
//

#import "ReusePool.h"

@interface ReusePool ()
//等待使用的队列
@property(strong, nonatomic)  NSMutableSet* waitUsingQueue;

//使用中的队列
@property(strong, nonatomic)  NSMutableSet* usingQueue;
@end

@implementation ReusePool

- (instancetype)init{
   self = [super init];
    if(self){
        _waitUsingQueue = [NSMutableSet set];
        _usingQueue = [NSMutableSet set];
    }
    return self;
    
}

- (UIView *)dequeueReusableView{
    UIView *view = [_waitUsingQueue anyObject];
    if(view == nil){
        return  nil;
    }else{
        [_waitUsingQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    }
}


- (void)addReusableView:(UIView *)view{
    if(view == nil){
        return;
    }
    //视图添加到使用中的队列
    [_usingQueue addObject:view];
}


- (void)resetPool{
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        //从使用队列移除
        [_usingQueue removeObject:view];
        
        //加入等待使用的队列
        [_waitUsingQueue addObject:view];
    }
}
@end
