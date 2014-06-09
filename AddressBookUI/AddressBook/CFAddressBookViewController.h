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

@interface CFAddressBookViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

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

/**
 *  转向编辑页面
 *
 *  @param aPerson 传给编辑页面的数据
 *  @param editing 设置编辑页面的初始编辑状态.YES,初始可编辑;NO,初始不可编辑.
 */
- (void) switchToEditViewWithData: (CFPerson *) aPerson
                          editing: (BOOL) editing;

@end
