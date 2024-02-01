//
//  MyNotication.m
//  ReLearn_IOS
//
//  Created by yyw on 2024/2/1.
//

#import "MyNotication.h"
//#import <Foundation/Foundation.h>
@implementation MyNotication

NSNotification *no;

- (instancetype)initWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo{
    self = [super init];
    if(self){
        _name = name;
        _object = object;
        _userInfo = userInfo;
    }
    return self;
}

+ (instancetype)initWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo{
    return [[self alloc] initWithName:name object:object userInfo:userInfo];
}
@end
