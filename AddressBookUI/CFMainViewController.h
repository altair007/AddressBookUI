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
@property (retain, nonatomic) CFAddressBookModel * model; //!< 通讯录数据模型
@end
