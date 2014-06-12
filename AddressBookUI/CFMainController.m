//
//  CFMainController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFMainController.h"
#import "CFAddressBookViewController.h"
#import "CFEditPersonViewController.h"
#import "CFAddressBookModel.h"
#import "CFPerson.h"
#import "UIAlertView+Blocks.h"

static CFMainController * sharedObj = nil;
@interface CFMainController ()

@end

@implementation CFMainController
+ (instancetype) sharedInstance
{
    @synchronized(self)
    {
        if (nil == sharedObj) {
            [[self alloc] init];
        }
    }
    
    return sharedObj;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self){
        if (nil == sharedObj) {
            sharedObj = [super allocWithZone:zone];
            return sharedObj;
        }
    }
    return nil;
}

- (instancetype) copyWithZone: (NSZone *) zone
{
    return  self;
}

- (instancetype)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return UINT_MAX;
}

- (oneway void)release
{
    
}

- (instancetype) autorelease
{
    return self;
}

- (id)init
{
    @synchronized(self){
        self = [super init];
        return self;
    }
}

-(void)dealloc
{
    self.model = nil;
    self.editPersonVC = nil;
    self.addressBookVC = nil;
    
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.addressBookVC.view reloadData];
}

- (void) switchToEditViewWithPerson: (CFPerson *) aPerson
                          editing: (BOOL) editing
{
    self.editPersonVC.person = aPerson;
    [self.editPersonVC setEditing: editing animated: YES];
    [self.addressBookVC.navigationController pushViewController: self.editPersonVC animated:YES];
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
    [self.addressBookVC.navigationController popToViewController:self.addressBookVC animated:YES];
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

- (void)setModel:(CFAddressBookModel *)model
{
    [model addObserver: self forKeyPath: @"countOfPersons" options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld context: NULL];
    [model retain];
    
    [_model removeObserver: self forKeyPath:@"countOfPersons"];
    [_model release];
    
    _model = model;
}

- (NSDictionary *) dictionaryOfPersons
{
    return self.model.personsByGroups;
}
@end
