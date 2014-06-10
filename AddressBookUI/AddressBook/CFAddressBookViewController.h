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
@class CFPerson;
@class CFMainViewController;
#import "CFMainViewController.h"

@interface CFAddressBookViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic, readonly) CFMainViewController * navigationController;

/**
 *  获取单例
 *
 *  @return 单例
 */
+ (instancetype) sharedInstance;

/**
 *  获取分区对应的通讯录成员
 *
 *  @param section 第几分区
 *
 *  @return 分区对应的通讯录成员
 */
- (NSArray *) personsInSection: (NSInteger)section;

/**
 *  获取分区某一行对应的通讯录成员.
 *
 *  @param indexPath 分区信息.
 *
 *  @return 分区某一行对应的通讯录成员.
 */
- (CFPerson *) personAtIndexPath: (NSIndexPath *) indexPath;

/**
 *  获取某一分区对应的群组名称.
 *
 *  @param section 第几分区
 *
 *  @return 分区对应的群组名称.
 */
- (NSString *) groupNameInSection: (NSInteger) section;

/**
 *  响应添加联系人事件
 *
 *  @param aButtonItem 被点击的buttonItem
 *
 */
- (void) didClickAddButtonItem: (UIBarButtonItem *) aButtonItem;

@end
