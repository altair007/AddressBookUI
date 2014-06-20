//
//  CFAddPersonViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-20.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddPersonViewController.h"
#import "CFAddressBookModel.h"
#import "NSString+IsAllNumbers.h"
#import "CFPerson.h"
#import "CFAvatarView.h"
#import "CFAddressBookModel.h"

@interface CFAddPersonViewController ()

@end

@implementation CFAddPersonViewController
- (void)loadView
{
    CFAddPersonView * addPersonView = [[CFAddPersonView alloc] initWithFrame:[[UIScreen mainScreen] bounds] delegate: self];
    self.view = addPersonView;
    [addPersonView release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEditing: YES animated: YES];
}

- (BOOL)handleDataOfPerson:(CFPerson *)person
{
    if (nil == self.person) {// 添加联系人
        return [[CFAddressBookModel sharedInstance] addPerson: person];
    }
    
    return [[CFAddressBookModel sharedInstance] updatePerson:person atTel: self.person.tel];
}

@end
