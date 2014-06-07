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

/**
 *  主控制器
 */
@interface CFMainViewController : UINavigationController
@property (retain, nonatomic) CFAddressBookViewController * addressBookVC; //!< 通讯录控制器
@property (retain, nonatomic) CFDetailViewController * detailVC; //!< 联系人详情控制器.
@end
