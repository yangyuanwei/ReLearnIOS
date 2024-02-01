//
//  NextViewController.h
//  ReLearn_IOS
//
//  Created by yyw on 2024/1/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NextViewControllerDeletage <NSObject>

@required
- (NSString *)getSomeValue:(NSString *)str;

@end

@interface NextViewController : UIViewController
@property(weak, nonatomic) id<NextViewControllerDeletage> delegate;
@end

NS_ASSUME_NONNULL_END
