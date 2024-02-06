//
//  UserCenter.m
//  ReLearn_IOS
//
//  Created by yyw on 2024/2/6.
//

#import "UserCenter.h"

@interface UserCenter ()
{
    //定义并非队列
    dispatch_queue_t concurrent_queue;
    //用户数据中心 字典
    NSMutableDictionary *userCenterDic;
}

@end
@implementation UserCenter

- (instancetype)init{
    if (self = [super init]) {
        concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT); //并发队列
        userCenterDic = [NSMutableDictionary dictionary];
    }
    return self;
}

//读 同步读取数据
- (id)objectForKey:(NSString *)key{
     __block id obj;
    //同步返回（立即返回）数据
    dispatch_sync(concurrent_queue, ^{
      obj =  [userCenterDic valueForKey:key];
    });
    return obj;
}

//写 异步栅栏 设置数据
- (void)setObject:(id)obj forkey:(NSString *)key{
    dispatch_barrier_async(concurrent_queue, ^{
        [self->userCenterDic setValue:obj forKey:key];
    });
    
}
@end
