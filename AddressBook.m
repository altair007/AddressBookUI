//
//  AddressBook.m
//  AddressBook
//
//  Created by   颜风 on 14-5-19.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "AddressBook.h"
#import "Person.h"

@implementation AddressBook

-(void)dealloc
{
    self.persons = nil;
    self.groups = nil;
    
    [super dealloc];
}

#pragma mark - 便利构造函数
+ (instancetype) book
{
    AddressBook * book;
    book = [[[self class] alloc]init];
    
    return book;
}

#pragma mark - 便利初始化
- (instancetype) init
{
    if (self = [super init])
    {
        self.persons = [NSMutableArray arrayWithCapacity: 42];
        self.groups = [NSMutableSet setWithCapacity: 42];
        
        // 设置一个默认分组:"默认"
        [self.groups addObject:@"默认"];
    }
    
    return self;
}

#pragma mark - 实例方法
- (void) addPerson: (Person *) person
{
    // person为空对象,直接返回.
    if (nil == person)
    {
        return;
    }
    
    
    __block BOOL isExist = NO;
    
    // 是否已经存在相同电话的联系人?
    [self.persons enumerateObjectsUsingBlock:^(Person * obj, NSUInteger idx, BOOL *stop)
    {
        if ([person.name isEqualToString:obj.name])
        {
            isExist = YES;
            * stop = YES;
        }
    }];
    
    // 已经存在电话号码相同的联系人,直接返回.
    if (isExist)
    {
        return;
    }
    
    // 新添联系人的分组,是否存在?
    __block BOOL isGroupExist = NO;
    
    NSArray * groups = [self.groups allObjects];
    
    [groups enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop)
    {
        if([obj isEqualToString:person.group])
        {
            isGroupExist = YES;
            * stop = NO;
        }
    }];
    
    //新添联系人的分组不存在,则直接返回.
    if (NO == isGroupExist)
    {
        return;
    }
    
    // 添加新的联系人
    [self.persons addObject:person];
}

- (Person *) personByTel: (NSString *) tel
{
    __block Person * person;
    
    [self.persons enumerateObjectsUsingBlock:^(Person * obj, NSUInteger idx, BOOL *stop)
    {
        if ([obj.tel isEqualToString:tel])
        {
            person = obj;
            * stop = YES;
        }
    }];
    
    return person;
}

- (NSArray *) personsByName: (NSString *) name
{
    __block NSMutableArray * persons =[[NSMutableArray alloc] initWithCapacity:42];
    
    [self.persons enumerateObjectsUsingBlock:^(Person * obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj.name isEqualToString:name])
         {
             [persons addObject:obj];
         }
     }];
    
    return persons;
}

- (NSArray *) personsByGroup: (NSString *) group
{
    __block NSMutableArray * persons = [NSMutableArray arrayWithCapacity:42];
    
    [self.persons enumerateObjectsUsingBlock:^(Person * obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj.group isEqualToString:group])
         {
             [persons addObject:obj];
         }
     }];
    
    return persons;
}

- (void) removePersonByTel: (NSString *) tel
{
    Person * person = [self personByTel:tel];
    
    [self.persons removeObject:person];
}

- (void) addGroup: (NSString *) group
{
    [self.groups addObject:group];
}

- (void) removeGroup: (NSString *) group
{
    // 不允许删除分组:"默认"
    if ([@"默认" isEqualToString: group])
    {
        return;
    }
    
    // 删除分组
    [self.groups removeObject:group];
    
    // 将此分组下的练习人的组名设为"默认"
    NSArray * persons = [self personsByGroup:group];
    [persons enumerateObjectsUsingBlock:^(Person * obj, NSUInteger idx, BOOL *stop)
    {
        obj.group = @"默认";
    }];
}

@end
