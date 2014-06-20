//
//  CFAddPersonViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-20.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFEditPersonViewController.h"
#import "CFAddPersonView.h"

@interface CFAddPersonViewController : CFEditPersonViewController
@property (retain, nonatomic)  CFAddPersonView * view;
@end
