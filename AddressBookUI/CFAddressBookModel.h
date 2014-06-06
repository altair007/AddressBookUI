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
@property (nonatomic, retain) NSMutableArray * persons; //!< 联系人
@property (nonatomic, retain) NSString * pathOfData; //!< 数据文件

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
 *  释放实例变量
 */
- (void)dealloc;
@end
