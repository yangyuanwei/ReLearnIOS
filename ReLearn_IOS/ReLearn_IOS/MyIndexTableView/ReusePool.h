//
//  ReusePoolTable.h
//  ReLearn_IOS
//
//  Created by yyw on 2024/1/31.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ReusePool : NSObject
//从重用池取出view
- (UIView *)dequeueReusableView;

//添加view到重用池
- (void)addReusableView:(UIView *)view;

//重置方法 ，讲当前使用中的视图view 移动到可重用队列
- (void)resetPool;
@end

NS_ASSUME_NONNULL_END
