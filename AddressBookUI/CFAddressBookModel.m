//
//  CFAddressBookModel.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddressBookModel.h"
#import "CFPerson.h"

@interface CFAddressBookModel ()
@property (nonatomic, retain, readwrite) NSMutableDictionary * personsByGroups; //!: 按姓名拼音首字母分组排序的字典,以首字母为键,以联系人数组为值
@property (nonatomic, retain, readwrite) NSMutableArray * persons; //!< 联系人
@property (nonatomic, retain, readwrite) NSString * pathOfData; //!< 数据文件
@property (assign, nonatomic, readwrite) NSUInteger countOfPersons; //!< 通讯录成员数量.主要用于标记数据源是否发生了变化.
@end

@implementation CFAddressBookModel
#pragma mark - 实例方法
- (instancetype)initWithFile:(NSString *)path
{
    if (self = [super init]) {
        self.pathOfData = path;

        self.persons = [NSKeyedUnarchiver unarchiveObjectWithFile: self.pathOfData];
        
        if (nil == self.persons) {
            self.persons = [[[NSMutableArray alloc] initWithCapacity: 42] autorelease];
        }
        
        [self setupPersonsByGroups];
        [self updateCountOfPersons];
        if (nil == self.persons) {
            return nil;
        }
    }
    
    return self;
}

- (BOOL) update
{
    BOOL result = [NSKeyedArchiver archiveRootObject: self.persons toFile: self.pathOfData];
    
    return result;
}

-(void)dealloc
{
    self.persons = nil;
    self.pathOfData = nil;
    self.personsByGroups = nil;
    
    [super dealloc];
}

- (void) setupPersonsByGroups
{
    self.personsByGroups = [[[NSMutableDictionary alloc] initWithCapacity:42] autorelease];
    [self.persons enumerateObjectsUsingBlock:^(CFPerson * aPerson, NSUInteger idx, BOOL *stop) {
        [self updatePersonsByGroupsWithPerson: aPerson];
    }];
}

- (NSString *) firstCharOfName: (NSString *) aChinenseName
{
    NSMutableString * first = [[[NSMutableString alloc] initWithString:[aChinenseName substringWithRange:NSMakeRange(0, 1)]] autorelease];
    
    CFRange range = CFRangeMake(0, 1);
    
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    
    return result.uppercaseString;
}

- (void) removePerson: (CFPerson *) aPerson
{
    if (NO == [self.persons containsObject: aPerson]) {// 不存在此联系人,则直接返回.
        return;
    }
    
    // 记录删除之前的状态
    NSMutableArray * personsTemp = [[NSMutableArray alloc] initWithArray: self.persons];
    
    // 删除
    [self.persons removeObject: aPerson];
    
    // 根据删除结果,进行不同操作
    BOOL result = [self update];
    
    if (NO == result) { // 删除失败,恢复初始状态,并返回
        self.persons = personsTemp;
        [personsTemp release];
        return;
    }
    [personsTemp release];
    
    // 删除成功

    // 更新通讯录字典
    // 获取此成员所在的数组.
    NSString * group = [self firstCharOfName:aPerson.name];
    NSMutableArray * persons =  [self.personsByGroups objectForKey: group];
    [persons removeObject: aPerson];
    if (0 == persons.count) {
        [self.personsByGroups removeObjectForKey: group];
    }
                                 
    // 设置通讯录成员数量,用于通知观察者数据发生了变化.
    [self updateCountOfPersons];
}

- (BOOL) addPerson: (CFPerson *) aPerson
{
    if([aPerson.name isEqualToString: @""] || [aPerson.tel isEqualToString: @""]){
        return NO;
    }
    
    if ([self.persons containsObject:aPerson]) { // 联系人已存在,直接修改.
        BOOL result = [self update];
        if (YES == result) {
            self.countOfPersons = self.persons.count;
        }
        return result;
    }
    
    // 记录添加前的状态
    NSMutableArray * personsTemp = [[NSMutableArray alloc] initWithArray: self.persons];
    
    // 根据添加结果,进行不同操作
    BOOL result = [self update];
    
    if (NO == result) { // 删除失败,恢复初始状态,并返回
        self.persons = personsTemp;
        [personsTemp release];
        return result;
    }
    [personsTemp release];
    
    // 添加成功
    // 更新通讯录字典
    [self updatePersonsByGroupsWithPerson: aPerson];
    
    // 设置通讯录成员数量,用于通知观察者数据发生了变化.
    [self updateCountOfPersons];
    
    return  result;
}

- (void) updatePersonsByGroupsWithPerson: (CFPerson *) aPerson
{
    if (nil == self.personsByGroups) {
        self.personsByGroups = [[[NSMutableDictionary alloc] initWithCapacity:42] autorelease];
    }
    
    // 获取联系人拼音首字母
    NSString * firstChar = [self firstCharOfName: aPerson.name];
    
    // 获取联系人对应的数组
    NSMutableArray * persons = [self.personsByGroups objectForKey: firstChar];
    
    // 判断键是否存在于数组中,不存在则创建
    if (nil == persons) {
        [self.personsByGroups setObject: [[[NSMutableArray alloc] initWithCapacity:42] autorelease] forKey:firstChar];
        // 重新获取联系人对应的数组
        persons = [self.personsByGroups objectForKey: firstChar];
    }
    
    // 判断联系人否已经存在.
    if (NO == [persons containsObject: aPerson]) {
        // 将联系人添加到对应数组中
        [persons addObject: aPerson];
    }
}

- (void) updateCountOfPersons
{
    self.countOfPersons = self.persons.count;
}
@end
