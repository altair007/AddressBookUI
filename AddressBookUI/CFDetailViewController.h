//
//  CFDetailViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFPerson;

@interface CFDetailViewController : UIViewController
@property (retain, nonatomic) CFPerson * person; //!< 联系人
@end
