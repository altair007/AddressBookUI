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

/**
 *  主控制器
 */
@interface CFMainViewController : UINavigationController
@property (assign, nonatomic) CFAddressBookViewController * addressBookVC; //!< 通讯录视图控制器
// FIXME: 此处retian,会导致循环引用问题,通过子类验证一下retaincount值,并寻找解决方案!
@property (retain, nonatomic) CFDetailViewController * detailVC; //!< 联系人详情视图控制器.
@property (retain, nonatomic) CFAddPersonViewController * addPersonVC; //!< 添加联系人页面的视图控制器
@property (retain, nonatomic) CFAddressBookModel * model; //!< 通讯录数据模型
@property (retain, nonatomic) CFEditPersonViewController * editPersonVC; //!< 编辑联系人页面的视图控制器.
@end
