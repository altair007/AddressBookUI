//
//  AddressBook.m
//  AddressBook
//
//  Created by   颜风 on 14-5-19.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

/**
 *  通讯录类,用来对联系人进行管理.
 */
@interface AddressBook : NSObject
#pragma mark - 属性
@property (nonatomic, retain) NSMutableArray * persons; //!< 联系人
@property (nonatomic, retain) NSMutableSet * groups; //!< 分组
#pragma mark - 便利构造函数
/**
 *  便利构造器
 *
 *  @return 一个新创建的对象.
 */
+ (instancetype) book;

#pragma mark - 便利初始化
/**
 *  初始化
 *
 *  通讯录初始化后都至少含有一个默认分组:"默认"
 *
 *  @return 返回初始化后的对象.
 */
- (instancetype) init;

#pragma mark - 实例方法
/**
 *  添加联系人
 *
 *  空对象,要添加的练习人的电话已经存在,或者联系人分组不存在,都会引起添加失败.
 *
 *  @param person 要添加的联系人
 */
- (void) addPerson: (Person *) person;

/**
 *  根据电话号码获取联系人.
 *
 *  @param tel 用来查询联系人的电话.
 *
 *  @return 返回电话对应的联系人,没有则返回nil.
 */
- (Person *) personByTel: (NSString *) tel;

/**
 *  根据姓名获取联系人,可能是多个,以数组形式返回.
 *
 *  @param name 用来查询联系人信息的姓名.
 *
 *  @return 以数组形式返回符合条件的联系人.
 */
- (NSArray *) personsByName: (NSString *) name;

/**
 *  根据组名获取联系人,以数组形式返回.
 *
 *  @param group 组名.
 *
 *  @return 以数组形式返回符合条件的联系人.
 */
- (NSArray *) personsByGroup: (NSString *) group;

/**
 *  根据电话删除联系人.
 *
 *  @param tel 要删除的联系人的电话.
 */
- (void) removePersonByTel: (NSString *) tel;

/**
 *  添加分组.
 *
 *  @param group 新的分组的名称.
 */
- (void) addGroup: (NSString *) group;

/**
 *  删除分组,保留此分组下的联系人,联系人组名置为"默认".
 *
 *  不允许删除默认的"默认"
 *
 *  @param group 要删除的分组的名称.
 */
- (void) removeGroup: (NSString *) group;

@end
