//
//  ViewController.m
//  ReLearn_IOS
//
//  Created by yyw on 2024/1/31.
//

#import "ViewController.h"
#import "Student.h"
#import "Techer.h"
#import "NextViewController.h"
#import "MyNotication/MyNotication.h"
#import "MyNotication/MyNoticationCenter.h"
@interface ViewController ()<NextViewControllerDeletage>
@property(strong, nonatomic)  Student* stu;
@property(strong, nonatomic)  Techer* techer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stu = [[Student alloc] init];
    self.techer = [[Techer alloc] init];
    
    if( [self.stu respondsToSelector:@selector(getPersonName)]){
        NSLog(@"%@",[self.stu getPersonName]) ;
    }
    
    if( [self.techer respondsToSelector:@selector(getPersonName)]){
        NSLog(@"%@",[self.techer getPersonName]) ;
    }
    
    [[MyNoticationCenter defaultCenter] addObserver:self selector:@selector(myNotifiti:) name:@"name" object:nil];
}


#pragma mark --通知回调方法
- (void)myNotifiti:(MyNotication *)notification{
    NSString *text = notification.object;
    NSLog(@"收到通知: %@",text);
    NSLog(@"当前线程是否是主线程: %d",[NSThread isMainThread]);
}

- (IBAction)goNext:(id)sender {


   UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NextViewController *nextVC = [sb instantiateViewControllerWithIdentifier:@"NextViewController"];
    nextVC.delegate = self;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}




#pragma mark ---NextViewControllerDeletage
-(NSString *)getSomeValue:(NSString *)str{
    NSLog(@"%@",str);
    
    
    return @"888888";
    NSNotification *not;
}


@synthesize age;

@end
