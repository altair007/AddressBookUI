//
//  CFAddressBookModel.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CFPerson;
@class FMDatabase;

// ???:如果把模型类设为单例的话,就不需要额外的控制器了!

/**
 *  通讯录模型类
 */
@interface CFAddressBookModel : NSObject
@property (retain, nonatomic, readonly) NSMutableDictionary * persons; //!: 联系人数据:按姓名拼音首字母分组排序的字典,以首字母为键,以联系人数组为值.
@property (retain, nonatomic, readonly) FMDatabase * db; //!< 数据库.

/**
 *  获取单例
 *
 *  @return 单例
 */
+ (instancetype) sharedInstance;

/**
 *  设置数据库连接.
 *
 *  @return YES,成功;NO,失败.
 */
- (BOOL) setupDB;

/**
 *  更新联系人数据.
 *s
 *  @return YES,更新成功;NO,更新失败.
 */
- (BOOL) updateData;

/**
 *  返回一个汉语名的拼音首字母
 *
 *  @param aChinenseName 一个汉语名字字符串
 *
 *  @return 汉语名字拼音首字母大写形式组成的字符串
 */
- (NSString *) firstCharOfName: (NSString *) aChinenseName;

/**
 *  删除某个电话号关联的联系人.
 *
 *  @param tel 电话号
 *
 *  @return YES,删除成功;NO,删除失败.
 */
- (BOOL) removePersonWithTel: (NSString *) tel;

/**
 *  添加联系人,姓名或电话号不能为空
 *
 *  @param aPerson 一个联系人
 *
 *  @return YES,添加成功;NO,添加失败
 */
- (BOOL) addPerson: (CFPerson *) aPerson;

/**
 *  更新联系人信息
 *
 *  @param aPerson 新的联系人信息对象.
 *  @param tel     联系人原来的手机号.
 *
 *  @return YES,成功;NO,失败.
 */
- (BOOL) updatePerson: (CFPerson *) aPerson
                atTel: (NSString *) tel;

@end
