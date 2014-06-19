//
//  CFPerson.m
//  AddressBook
//
//  Created by   颜风 on 14-5-19.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//
#import <Foundation/Foundation.h>

#pragma mark - 编码键常量
#define kAvatarKey @"avatar"
#define kNameKey @"name"
#define kSexKey @"key"
#define kAgeKey @"age"
#define kTelKey @"tel"
#define kIntro @"intro"
/**
 * 通讯录成员类,用作通讯录成员
 */
@interface CFPerson : NSObject
@property (copy, nonatomic) NSString * name; //!< 姓名.
@property (copy, nonatomic) NSString * avatar; //!< 头像图片名称.
@property (assign, nonatomic) BOOL sex; //!< 性别.NO, 表示男;YES,表示女.
@property (assign, nonatomic) NSUInteger age; //!< 年龄.
@property (copy, nonatomic) NSString * tel; //!< 电话.
@property (copy, nonatomic) NSString * intro; //!< 简介.

/**
 *  便利构造器.
 *
 *  @param name       姓名.
 *  @param avatar     头像.
 *  @param sex        性别.
 *  @param age        年龄.
 *  @param tel        电话.
 *  @param intro      简介.
 *
 *  @return 实例对象.
 */
+ (instancetype) personWithName: (NSString *) name
                         avatar: (NSString *) avatar
                            sex: (BOOL) sex
                            age: (NSUInteger) age
                            tel: (NSString *) tel
                          intro: (NSString *) intro;

/**
 *  便利初始化
 *
 *  @param name   姓名
 *  @param avatar 头像名称
 *  @param sex    性别.NO,男;YES,女.
 *  @param age    年龄
 *  @param tel    地址
 *
 *  @return 初始化后的对象
 */
- (instancetype) initWithName: (NSString *) name
                       avatar: (NSString *) avatar
                          sex: (BOOL) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel
                        intro: (NSString *) intro;

/**
 *  对象是否与另一对象等价.
 *
 *  @param aPerson 用来比较的对象.
 *
 *  @return YES,等价;NO,不等价.
 */
- (BOOL) isEqualToPerson: (CFPerson *) aPerson;

@end
