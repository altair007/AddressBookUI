//
//  CFMainViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFMainViewController.h"
#import "CFEditPersonViewController.h"
#import "CFPerson.h"

@interface CFMainViewController ()

@end

@implementation CFMainViewController
-(void)dealloc
{
    self.model = nil;
    
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
    CFEditPersonViewController * editPersonVC = [CFEditPersonViewController sharedInstance];
    editPersonVC.person = aPerson;
    [editPersonVC setEditing: editing animated: YES];
    [self pushViewController: editPersonVC animated:YES];
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

@end
