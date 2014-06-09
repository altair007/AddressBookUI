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
#define kNameOfDefaultImg @"nameOfdefaultImg"

/**
 * 通讯录成员类,用作通讯录成员
 */
@interface CFPerson : NSObject <NSCoding>

#pragma mark - 属性
@property (nonatomic, copy) NSString * name; //!< 姓名.
@property (retain, nonatomic) NSString * avatar; //!< 头像图片名称
@property (nonatomic, retain) NSString * sex; //!< 性别
@property (assign, nonatomic) NSUInteger age; //!< 年龄
@property (nonatomic, copy) NSString * tel; //!< 电话.
@property (retain, nonatomic, readonly) NSString * nameOfdefaultImg; //!< 默认头像名称.
@property (retain, nonatomic, readonly) UIImage * avatarImage; //!< 头像图片,根据头像名称动态获取.

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

- (instancetype) initWithName: (NSString *) name
                       avatar: (NSString *) avatar
                          sex: (NSString *) sex
                          age: (NSUInteger) age
                          tel: (NSString *) tel
             nameOfdefaultImg: (NSString *) nameOfdefaultImg;

/**
 *  根据头像图片路径更新头像图片.
 */
- (void) updateAvatarImage;

#pragma mark - NSCoding协议方法
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
