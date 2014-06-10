//
//  CFMainViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFAddressBookViewController;
@class CFEditPersonViewController;
@class CFAddressBookModel;
@class CFPerson;

#define PATH_KVO_PERSONSBYGROUPS @"personsByGroups"

/**
 *  主控制器
 */
@interface CFMainViewController : UINavigationController
@property (assign, nonatomic) CFAddressBookViewController * addressBookVC; //!< 通讯录视图控制器
@property (assign, nonatomic) CFEditPersonViewController * editPersonVC; //!< 编辑联系人页面视图控制器
@property (retain, nonatomic) CFAddressBookModel * model; //!< 通讯录数据模型

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

/**
 *  添加联系人,姓名或电话号不能为空
 *
 *  @param aPerson 一个联系人
 *
 *  @return YES,添加成功;NO,添加失败
 */
- (BOOL) addPerson: (CFPerson *) aPerson;

/**
 *  删除联系人
 *
 *  @param aPerson 要删除的联系人
 */
- (void) removePerson: (CFPerson *) aPerson;

@end
