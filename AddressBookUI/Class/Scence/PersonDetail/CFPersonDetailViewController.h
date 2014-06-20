//
//  CFPersonDetailViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-20.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFEditPersonViewController.h"
#import "CFPersonDetailView.h"

@interface CFPersonDetailViewController : CFEditPersonViewController
@property (retain, nonatomic) CFPersonDetailView * view; //!< 重新声明超类view属性.
@end
