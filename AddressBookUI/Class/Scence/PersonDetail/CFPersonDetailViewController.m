//
//  CFPersonDetailViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-20.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFPersonDetailViewController.h"
#import "CFAddressBookModel.h"
#import "CFPerson.h"

@interface CFPersonDetailViewController ()

@end

@implementation CFPersonDetailViewController

- (void)loadView
{
    CFPersonDetailView * personDetailView = [[CFPersonDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds] delegate: self];
    self.view = personDetailView;
    [personDetailView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEditing: NO animated: YES];
}

- (BOOL)handleDataOfPerson:(CFPerson *)person
{
    return [[CFAddressBookModel sharedInstance] updatePerson: person atTel: self.person.tel];
}
@end
