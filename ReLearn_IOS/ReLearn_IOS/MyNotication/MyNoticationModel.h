//
//  MyNoticationModel.h
//  ReLearn_IOS
//
//  Created by yyw on 2024/2/1.
//

#import <Foundation/Foundation.h>
#import "MyNotication.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^NSOperationQueueBlock)(MyNotication *notification);
/// 观察者模型对象
@interface MyNoticationModel : NSObject

//观察者对象
@property(strong, nonatomic)  id observer;

//执行方法
@property(assign, nonatomic)  SEL selector;

//通知名称
@property(copy, nonatomic)  NSString* notificationName;

//携带参数
@property(strong, nonatomic)  id object;

//队列
@property(strong, nonatomic)  NSOperationQueue* queue;

//回调
@property(copy, nonatomic)  NSOperationQueueBlock block;

@end

NS_ASSUME_NONNULL_END
