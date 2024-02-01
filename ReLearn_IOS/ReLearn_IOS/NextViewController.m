//
//  NextViewController.m
//  ReLearn_IOS
//
//  Created by yyw on 2024/1/31.
//

#import "NextViewController.h"
#import "MyIndexTableView/IndexTableView.h"
#import "MyNotication/MyNotication.h"
#import "MyNotication/MyNoticationCenter.h"
@interface NextViewController ()<IndexTableViewDataSource, UITableViewDelegate,UITableViewDataSource>
{
    IndexTableView *tableView; //带有索引条的tableView
    UIButton *button;
    NSMutableArray *dataSouce;
}
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableView = [[IndexTableView alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.indexDataSource = self;
    
    [self.view addSubview:tableView];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(doAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //数据源
    dataSouce = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [dataSouce addObject:@(i+1)];
    }
    
}

- (void)doAction:(id)sender{
    NSLog(@"reloadData");
    [tableView reloadData];
    
    [[MyNoticationCenter defaultCenter] postNotificationName:@"name" object:@"我刷新啦啦啦啦啦" userInfo:nil];
    
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    if([self.delegate respondsToSelector:@selector(getSomeValue:)]){
      NSLog(@"%@", [self.delegate getSomeValue:@"我是从Next控制器传递过来的参数"]);
    }
    
}

- (nonnull NSArray<NSString *> *)indexTitleForTableView:(nonnull UITableView *)tabelView { 
    
    //奇数次调用返回6个字母，偶数次调用返回11个
    
    static BOOL change = NO;
    if(change){
        change = NO;
        return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M"];
    }else{
        change = YES;
        return @[@"A",@"B",@"C",@"D",@"E",@"F"];
    }
    
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSouce count];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *ID = @"reuserId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
      cell =  [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:ID];
    }
  
    cell.textLabel.text = [[dataSouce objectAtIndex:indexPath.row] stringValue];
    return cell ;
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}




@end
