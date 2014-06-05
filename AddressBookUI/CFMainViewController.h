//
//  CFMainViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFMainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) NSMutableArray * persons; //!< 联系人
@end
