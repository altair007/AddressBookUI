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
@interface CFPerson : NSObject <NSCoding>

#pragma mark - 属性
@property (copy, nonatomic) NSString * name; //!< 姓名.
@property (copy, nonatomic) NSString * avatarName; //!< 头像图片名称.
@property (copy, nonatomic) NSString * sex; //!< 性别.
@property (assign, nonatomic) NSUInteger age; //!< 年龄.
@property (copy, nonatomic) NSString * tel; //!< 电话.
@property (copy, nonatomic) NSString * intro; //!< 简介.

/**
 *  便利初始化
 *
 *  @param name   姓名
 *  @param avatar 头像名称s
 *  @param sex    性别
 *  @param age    年龄
 *  @param tel    地址
 *
 *  @return 初始化后的对象
 */
- (instancetype) initWithName: (NSString *) name
                   avatarName: (NSString *) avatarName
                          sex: (NSString *) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel
                        intro: (NSString *) intro;
@end
