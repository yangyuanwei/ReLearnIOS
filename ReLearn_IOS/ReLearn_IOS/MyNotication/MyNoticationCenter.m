//
//  MyNoticationCenter.m
//  ReLearn_IOS
//
//  Created by yyw on 2024/2/1.
//

#import "MyNoticationCenter.h"
#import "MyNoticationModel.h"

@interface MyNoticationCenter()

/// 保存观察者对象和 name  key:name   value:[MyNoticationModel0,MyNoticationModel1,MyNoticationModel2 ...]
@property(strong, nonatomic)  NSMutableDictionary* observerJson;
@end

@implementation MyNoticationCenter
+ (nonnull instancetype)defaultCenter {
    static MyNoticationCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MyNoticationCenter alloc] init];
        instance.observerJson = [NSMutableDictionary dictionary];
    });
    return instance;
}


- (void)addObserver:(nonnull id)observer selector:(nonnull SEL)aSelector name:(nonnull NSString *)aName object:(nullable id)anObject {
    
    //创建model
    MyNoticationModel *model = [[MyNoticationModel alloc] init];
    model.observer = observer;
    model.selector = aSelector;
    model.notificationName = aName;
    model.object = anObject;
    
    //判断是否有这个name 对应value.
    if (![self.observerJson objectForKey:aName]) { //没有，新建一个
        NSMutableArray *oberverArray = [NSMutableArray array];
        [oberverArray addObject:model];
        
        //array 添加进字典中（hash ）,key 是通知名
        [self.observerJson setValue:oberverArray forKey:aName];
    }else{
        
        // 如果存在,取出来,继续添加进对应数组即可
        NSMutableArray *oberverArray = [self.observerJson valueForKey:aName];
        [oberverArray addObject:model];
    }
}


- (nonnull id<NSObject>)addObserverForName:(nonnull NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(nonnull void (^)(MyNotication * _Nonnull __strong))block {
    //创建model
    MyNoticationModel *observer = [[MyNoticationModel alloc] init];
    observer.notificationName = name;
    observer.object = obj;
    observer.queue = queue;
    observer.block = block;
    
    //判断是否有这个name 对应value.
    if (![self.observerJson objectForKey:name]) { //没有，新建一个
        NSMutableArray *oberverArray = [NSMutableArray array];
        [oberverArray addObject:observer];
        
        //array 添加进字典中（hash ）,key 是通知名
        [self.observerJson setValue:oberverArray forKey:name];
    }else{
        
        // 如果存在,取出来,继续添加进对应数组即可
        NSMutableArray *oberverArray = [self.observerJson valueForKey:name];
        [oberverArray addObject:observer];
    }
    
    return nil;
}

- (void)postNotification:(MyNotication *)notification {
    //根据key：通知名 得到观察者数组
    NSMutableArray *oberverArrays = [self.observerJson valueForKey:notification.name];
    
    //遍历观察者数组，执行每个观察者的 SEL方法，传递消息
    [oberverArrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MyNoticationModel *observerModel = (MyNoticationModel *)obj;
        SEL selector = observerModel.selector;
        id observer = observerModel.observer;
        
        if(!observerModel.queue ){ //没有队列
            // 下面这样写的目的是:手动忽略clang编译器警告
            // 参考:http://blog.csdn.net/qq_18505715/article/details/76087558
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

            [observer performSelector:selector withObject:notification];
            
#pragma clang diagnostic pop
        }else{
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                //这里通过block 回调出去
                observerModel.block(notification);
            }];
            
            // 如果添加观察者 传入 队列，那么任务就放在队列中执行(子线程异步执行)
            [observerModel.queue addOperation:operation];
        }
        
        
    }];
    
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject {
    [self postNotificationName:aName object:anObject userInfo:nil];
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo {
    MyNotication *notification = [[MyNotication alloc] initWithName:aName object:anObject userInfo:aUserInfo];
    [self postNotification:notification];
}



- (void)removeObserver:(nonnull id)observer {
    [self removeObserver:observer name:nil object:nil];
    
}

- (void)removeObserver:(nonnull id)observer name:(nullable NSString *)aName object:(nullable id)anObject {
    // 移除观察者 - 当有 name 参数时
    if(aName.length > 0 && [self.observerJson valueForKey:aName]){
        NSMutableArray *modelArrays = [self.observerJson valueForKey:aName];
        [modelArrays enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MyNoticationModel *model = (MyNoticationModel *)obj;
            if ([model.observer isEqual:observer]) {
                [modelArrays removeObject:observer];
            }
        }];
      
    }else{
        // 移除观察者 - 当没有 name 参数时
        if (self.observerJson.allKeys.count > 0 && self.observerJson.allValues.count > 0) {
            
            for (int i = 0; i < self.observerJson.allKeys.count; i++) {
                
                NSMutableArray *allKeyArrays = [self.observerJson valueForKey:self.observerJson.allKeys[i]];
                BOOL isStop = NO;   // 如果找到后就不再遍历后面的数据了
                
                for (int j = 0; j < allKeyArrays.count; j++) {
                    MyNoticationModel *allvalueModel = allKeyArrays[j];
                    if([allvalueModel.observer isEqual:observer]){
                        [allKeyArrays removeObject:allvalueModel];
                        isStop = YES;
                        break;
                    }
                }
                
                
               if (isStop) {   // 找到了,退出循环
                   break;
               }
            }
            
        }else{
            NSAssert(false, @"当前通知中心没有观察者");
        }
        
    }
  
}


@end
