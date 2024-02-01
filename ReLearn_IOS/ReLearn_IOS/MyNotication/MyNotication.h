//
//  MyNotication.h
//  ReLearn_IOS
//
//  Created by yyw on 2024/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyNotication : NSObject
@property (readonly, copy) NSString *name;
@property (nullable, readonly, retain) id object;
@property (nullable, readonly, copy) NSDictionary *userInfo;

- (instancetype)initWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;

+ (instancetype)initWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
