//
//  MyNoticationCenter.h
//  ReLearn_IOS
//
//  Created by yyw on 2024/2/1.
//

#import <Foundation/Foundation.h>
#import "MyNotication.h"
NS_ASSUME_NONNULL_BEGIN


//通知中心
@interface MyNoticationCenter : NSObject

//单例模式
+(instancetype)defaultCenter;

#pragma mark -- 添加到通知中心
- (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(nullable id)anObject;

- (id <NSObject>)addObserverForName:(NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (NS_SWIFT_SENDABLE ^)(NSNotification *notification))block ;

#pragma mark -- 发送通知
- (void)postNotification:(MyNotication *)notification;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;


#pragma mark -- 移除通知
- (void)removeObserver:(id)observer;
- (void)removeObserver:(nonnull id)observer name:(nullable NSString *)aName object:(nullable id)anObject ;
@end

NS_ASSUME_NONNULL_END
