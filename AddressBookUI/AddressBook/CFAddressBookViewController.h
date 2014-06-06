//
//  CFAddressBookViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFAddressBookModel;
@class CFDetailViewController;


@interface CFAddressBookViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) CFAddressBookModel * addressBookModel; //!< 通讯录模型.
@property (retain, nonatomic, readonly) CFDetailViewController * detailVC; //!< 联系人详情控制器.

@end
