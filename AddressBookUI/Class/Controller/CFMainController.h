//
//  CFMainController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CFAddressBookViewController;
@class CFEditPersonViewController;
@class CFAddressBookModel;
@class CFPerson;

/**
 *  主控制器
 */
@interface CFMainController : NSObject
@property (retain,nonatomic, readonly) UINavigationController * navigationController; //!< 导航栏.
@property (retain, nonatomic, readonly) CFAddressBookViewController * addressBookVC; //!< 通讯录视图控制器
@property (retain, nonatomic, readonly) CFEditPersonViewController * editPersonVC; //!< 编辑联系人页面视图控制器
@property (retain, nonatomic) CFAddressBookModel * model; //!< 通讯录数据模型

/**
 *  获取单例
 *
 *  @return 单例
 */
+ (instancetype) sharedInstance;

/**
 *  转向编辑页面.
 *
 *  @param aPerson 传给编辑页面的数据.
 *  @param editing 设置编辑页面的初始编辑状态.YES,初始可编辑;NO,初始不可编辑.
 */
- (void) switchToEditViewWithPerson: (CFPerson *) aPerson
                          editing: (BOOL) editing;

/**
 *  转向添加联系人页面.
 */
- (void) switchToAddPersonView;

/**
 *  转向联系人详情页面.
 *
 *  @param aPerson 要查看此联系人的详细信息.
 */
- (void) switchToPersonDetailViewWithPerson: (CFPerson *) aPerson;

/**
 *  转向通讯录视图
 */
- (void) switchToAddressBookView;

@end
