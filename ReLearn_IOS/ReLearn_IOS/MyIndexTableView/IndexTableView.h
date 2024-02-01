//
//  IndexTableView.h
//  ReLearn_IOS
//
//  Created by yyw on 2024/1/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IndexTableViewDataSource <NSObject>

//字母索引的数据源方法
- (NSArray<NSString *> *)indexTitleForTableView:(UITableView *)tabelView;

@end

@interface IndexTableView : UITableView
@property(weak, nonatomic) id<IndexTableViewDataSource> indexDataSource;
@end

NS_ASSUME_NONNULL_END
