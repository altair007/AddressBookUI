//
//  CFMainViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFAddressBookViewController;
@class CFDetailViewController;
@class CFAddressBookModel;
@class CFAddPersonViewController;
@class CFEditPersonViewController;
@class CFPerson;

/**
 *  主控制器
 */
@interface CFMainViewController : UINavigationController
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
@end
