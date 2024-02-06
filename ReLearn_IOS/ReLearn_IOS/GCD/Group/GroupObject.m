//
//  GroupObject.m
//  ReLearn_IOS
//
//  Created by yyw on 2024/2/6.
//

#import "GroupObject.h"

@interface GroupObject (){
    dispatch_queue_t concurrent_queue; //并非队列
    NSMutableArray <NSURL *> *arrayURLs; //要下载图片的url
}
@end

@implementation GroupObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建并发队列
        concurrent_queue = dispatch_queue_create("group_queue", DISPATCH_QUEUE_CONCURRENT);
        arrayURLs = [NSMutableArray array];
        
    }
    return self;
}

- (void)handle{
    //创建group
    dispatch_group_t group = dispatch_group_create();
    
    for (NSURL *url in arrayURLs) {
        //异步 组分派到并发队列中
        dispatch_group_async(group, concurrent_queue, ^{
            //下载任务
        });
    }
    
    //组group执行完后，执行的方法
    dispatch_group_notify(group, concurrent_queue, ^{
        //当添加到组里面的所有任务执行完成，会调用这个block
        NSLog(@"所有图片下载完整");
    });
}

@end
