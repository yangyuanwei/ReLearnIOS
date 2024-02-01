//
//  Person.h
//  ReLearn_IOS
//
//  Created by yyw on 2024/1/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PersonDelegate <NSObject>
@required
- (NSString *)getPersonName;

@end


@interface Person : NSObject
//@property(weak, nonatomic) <PersonDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
