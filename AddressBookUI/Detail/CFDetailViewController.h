//
//  CFDetailViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFPerson;

/**
 *  联系人详情的视图控制器类
 */
@interface CFDetailViewController : UIViewController
@property (retain, nonatomic) CFPerson * person; //!< 要展示其信息的联系人
@end
