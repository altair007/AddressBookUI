//
//  CFAddressBookModel.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-6.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CFPerson;

/**
 *  通讯录模型类
 */
@interface CFAddressBookModel : NSObject
#pragma mark - 属性
@property (retain, nonatomic, readonly) NSMutableArray * persons; //!< 联系人
@property (retain, nonatomic, readonly) NSString * pathOfData; //!< 数据文件
@property (retain, nonatomic, readonly) NSMutableDictionary * personsByGroups; //!: 按姓名拼音首字母分组排序的字典,以首字母为键,以联系人数组为值
#pragma mark - 实例方法
/**
 *  从文件中获取数据,进行初始化
 *
 *  @param path 数据文件路径
 *
 *  @return 返回初始化后的对象
 */
- (instancetype) initWithFile: (NSString *) path;

/**
 *  将数据写入数据源文件
 *
 *  @return YES,成功;NO,写入失败.
 */
- (BOOL) update;

/**
 *  初始设置peronsByGroups属性
 *
 */
- (void) updatePersonsByGroups;

/**
 *  返回一个汉语名的拼音首字母
 *
 *  @param aChinenseName 一个汉语名字字符串
 *
 *  @return 汉语名字拼音首字母大写形式组成的字符串
 */
- (NSString *) firstCharOfName: (NSString *) aChinenseName;

/**
 *  删除联系人
 *
 *  @param aPerson 要删除的联系人
 */
- (void) removePerson: (CFPerson *) aPerson;

/**
 *  添加联系人,姓名或电话号不能为空
 *
 *  @param aPerson 一个联系人
 *
 *  @return YES,添加成功;NO,添加失败
 */
- (BOOL) addPerson: (CFPerson *) aPerson;

@end
