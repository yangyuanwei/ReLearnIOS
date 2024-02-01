//
//  IndexTableView.m
//  ReLearn_IOS
//
//  Created by yyw on 2024/1/31.
//

#import "IndexTableView.h"
#import "ReusePool.h"

@interface IndexTableView ()
{
    UIView *_containerView;
    ReusePool *_reusePool;
}

@end

@implementation IndexTableView
- (void)reloadData{
    [super reloadData];
    
    if(!_containerView){
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        
        //避免索引条随着table滚动
        [self.superview insertSubview:_containerView aboveSubview:self];
    }
    
    if(!_reusePool){
        _reusePool = [[ReusePool alloc] init];
    }
    
    //标记所有视图为可重用状态
    [_reusePool resetPool];
    
    //reload字母索引条
    [self reloadIndexBar];
}

- (void)reloadIndexBar{
    
    //获取字母索引条的🧑‍🏫内容
    NSArray <NSString *> *arrayTitles = nil;
    if ([self.indexDataSource respondsToSelector:@selector(indexTitleForTableView:)]) {
        arrayTitles = [self.indexDataSource indexTitleForTableView:self];
    }
    
    //判断字母索引条是否为空
    if(!arrayTitles || arrayTitles.count <= 0){
        [_containerView setHidden:YES];
        return;
    }
    
    NSUInteger count = arrayTitles.count;
    
    CGFloat buttonWith = 60;
    CGFloat buttonHeight = self.frame.size.height / count;
    
    for (int i = 0; i < arrayTitles.count; i++) {
        NSString *title = [arrayTitles objectAtIndex:i];
        UIButton *btn = (UIButton *) [_reusePool dequeueReusableView];
        
        if(!btn){
            btn = [[UIButton alloc] initWithFrame:CGRectZero];
            btn.backgroundColor = [UIColor whiteColor];
            
            //注册buton到重用池
            [_reusePool addReusableView:btn];
            NSLog(@"新创建一个Button");
        }else{
            NSLog(@"Button重用了");
        }
        
        //添加button到父视图
        [_containerView addSubview:btn];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置button的坐标
        [btn setFrame:CGRectMake(0, i * buttonHeight, buttonWith, buttonHeight)];
    }
    
    [_containerView setHidden:NO];
    _containerView.frame = CGRectMake(self.frame.origin.x + self.frame.size.width - buttonWith, self.frame.origin.y, buttonWith, self.frame.size.height);
}
@end
