//
//  Person.m
//  AddressBook
//
//  Created by   颜风 on 14-5-19.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "Person.h"

@implementation Person

-(void)dealloc
{
    self.avatar = nil;
    self.name = nil;
    self.tel = nil;
    self.group = nil;
    
    [super dealloc];
}
#pragma mark - 便利构造器
+ (instancetype) personWithName: (NSString *) name
                                   tel: (NSString *) tel
{
    Person * person;
    person = [[self class] personWithName: name
                                             tel: tel
                                           group: nil];
    
    return person;
}

+ (instancetype) personWithName: (NSString *) name
                                   tel: (NSString *) tel
                                 group: (NSString *) group
{
    Person * person;
    person = [[[self class] alloc]initWithName:name tel:tel group:group];
    
    return person;
}

#pragma mark - 便利初始化
- (instancetype) initWithName: (NSString *) name
                       avatar: (NSString *) avatar
                          sex: (NSString *) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel
{
    if (self = [super init]) {
        self.name = name;
        self.avatar = avatar;
        self.sex = sex;
        self.age = age;
        self.tel = tel;
    }
    
    return self;
}

- (instancetype) initWithName: (NSString *) name
                          tel: (NSString *) tel
{
    if (self = [self initWithName:name tel:tel group:nil])
    {
        // 暂时不需要做任何事
    }
    
    return self;
}

- (instancetype) initWithName: (NSString *)name
                          tel: (NSString *)tel
                        group: (NSString *) group
{
    if (self = [super init])
    {
        // 电话是否全部为数字?
        if (NO == [self isAllNumber:tel])
        {
            return nil;
        }
        
        // 去除姓名两端的空格
        name = [name stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceCharacterSet]];
        
        // 姓名是否为空?
        if (nil == name || [@"" isEqualToString: name])
        {
            name = @"无名氏";
        }
        
        // 分组是否为空?
        if (nil == group || [@"" isEqualToString:group])
        {
            group = @"默认";
        }
        
        // 设置属性
        self.name = name;
        self.tel = tel;
        self.group = group;
    }
    
    return self;
}

#pragma mark - 实例方法
- (void) show
{
    NSString * info;
    info = [NSString stringWithFormat:@"%@ %@ %@", self.name, self.tel, self.group];
    
    NSLog(@"%@", info);
}

#pragma makr - 工具函数
- (BOOL) isAllNumber: (NSString *) str
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"self MATCHES '^[0-9]+$'"];
    
    BOOL result = [predicate evaluateWithObject:str];
    
    return result;
}

@end
