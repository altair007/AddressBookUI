//
//  CFMainViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFMainViewController.h"
#import "CFAddressBookViewController.h"
#import "CFEditPersonViewController.h"
#import "CFAddressBookModel.h"
#import "CFPerson.h"

@interface CFMainViewController ()

@end

@implementation CFMainViewController
-(void)dealloc
{
    [self.model removeObserver:self forKeyPath:PATH_KVO_PERSONSBYGROUPS];
    self.model = nil;
    self.editPersonVC = nil;
    self.addressBookVC = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    [self.addressBookVC.view reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && nil == self.view.window) {
        self.view = nil;
    }
}

- (void) switchToEditViewWithPerson: (CFPerson *) aPerson
                          editing: (BOOL) editing
{
    self.editPersonVC.person = aPerson;
    [self.editPersonVC setEditing: editing animated: YES];
    [self pushViewController: self.editPersonVC animated:YES];
}

- (void) switchToAddPersonView
{
    CFPerson * person = [[CFPerson alloc] init];
    [self switchToEditViewWithPerson: person editing: YES];
    [person release];
}

- (void) switchToPersonDetailViewWithPerson: (CFPerson *) aPerson
{
    [self switchToEditViewWithPerson: aPerson editing: NO];
}

- (void) switchToAddressBookView
{
    [self popToViewController:self.addressBookVC animated:YES];
}

- (void)setModel:(CFAddressBookModel *)model
{
    [model retain];
    [_model release];
    _model = model;
    [self.model addObserver:self forKeyPath:PATH_KVO_PERSONSBYGROUPS options:NSKeyValueObservingOptionNew context: NULL];
}

- (BOOL) addPerson: (CFPerson *) aPerson
{
    BOOL result = [self.model addPerson: aPerson];
    
    return result;
}

- (void) removePerson: (CFPerson *) aPerson
{
    [self.model removePerson: aPerson];
}

@end
