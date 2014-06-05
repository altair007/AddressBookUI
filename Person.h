//
//  Person.m
//  AddressBook
//
//  Created by   颜风 on 14-5-19.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//
#import <Foundation/Foundation.h>

/**
 * 通讯录成员类,用作通讯录成员
 */
@interface Person : NSObject

#pragma mark - 属性
// FIXME: 头像,传个名字更合适吧?节省空间,便于存储!
@property (retain, nonatomic) NSString * avatar; //!< 头像图片名称
@property (nonatomic, copy) NSString * name; //!< 姓名.
@property (nonatomic, retain) NSString * sex; //!< 性别
@property (assign, nonatomic) NSUInteger age; //!< 年龄
@property (nonatomic, copy) NSString * tel; //!< 电话.
@property (nonatomic ,copy) NSString * group; //!< 分组名称.

#pragma mark - 便利构造器
/**
 *  根据姓名和电话创建联系人
 *
 *  @param name 姓名,如果姓名为空,默认设为"无名氏".
 *  @param tel  电话,如果电话为空,返回nil对象.
 *
 *  @return 新的联系人对象.
 */
+ (instancetype) personWithName: (NSString *) name
                                   tel: (NSString *) tel;

/**
 *  根据姓名,电话和分组信息创建联系人
 *
 *  @param name  姓名,如果为空,默认设为"无名氏".
 *  @param tel   电话,如果设为空,返回nil对象.
 *  @param group 所在分组名称呢过,如果为空,默认设为"默认".
 * 
 *  @return 新创建的联系人对象.
 */
+ (instancetype) personWithName: (NSString *) name
                                   tel: (NSString *) tel
                                 group: (NSString *) group;

#pragma mark - 便利初始化
/**
 *  根据姓名,电话初始化联系人
 *
 *  @param name  姓名,如果为空,默认设为"无名氏".
 *  @param tel   电话,如果设为空,返回nil对象.
 *
 *  @return 初始化后的联系人对象.
 */
- (instancetype) initWithName: (NSString *) name
                          tel: (NSString *) tel;

/**
 *  便利初始化
 *
 *  @param name   姓名
 *  @param avatar 头像名称
 *  @param sex    性别
 *  @param age    年龄
 *  @param tel    地址
 *
 *  @return 初始化后的对象
 */
- (instancetype) initWithName: (NSString *) name
                       avatar: (NSString *) avatar
                          sex: (NSString *) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel;
/**
 *  根据姓名,电话和分组信息初始化联系人
 *
 *  @param name  姓名,如果为空,默认设为"无名氏".
 *  @param tel   电话,如果设为空,返回nil对象.
 *  @param group 所在分组名称呢过,如果为空,默认设为"默认".
 *
 *  @return 初始化后的联系人对象.
 */
- (instancetype) initWithName: (NSString *)name
                          tel: (NSString *)tel
                        group: (NSString *) group;

#pragma mark - 实例方法
/**
 *  显示联系人信息
 */
- (void) show;

#pragma makr - 工具函数
/**
 *  判断一个字符串是否全部是数字:0~9.
 *
 *  @param str 要判断的字符串.
 *
 *  @return 如果只含有0~9以外的字符,返回YES;str为nil或者空串,或者含有0~9以外的字符,返回NO.
 */
- (BOOL) isAllNumber: (NSString *) str;

@end
