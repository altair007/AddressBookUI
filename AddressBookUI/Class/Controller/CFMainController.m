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

@interface CFMainController ()
@property (retain,nonatomic, readwrite) UINavigationController * navigationController; //!< 导航栏.
@property (retain, nonatomic, readwrite) CFAddressBookViewController * addressBookVC; //!< 通讯录视图控制器
@property (retain, nonatomic, readwrite) CFEditPersonViewController * editPersonVC; //!< 编辑联系人页面视图控制器
@end

@implementation CFMainController
#pragma mark - 实现单例
static CFMainController * sharedObj = nil;

+ (instancetype) sharedInstance
{
    if (nil == sharedObj) {
        sharedObj = [[self alloc] init];
    }
    
    return sharedObj;
}

+ (instancetype) allocWithZone:(struct _NSZone *)zone
{
    if (nil == sharedObj) {
        sharedObj = [super allocWithZone:zone];
        return sharedObj;
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
    return;
}

- (instancetype) autorelease
{
    return self;
}

#pragma mark - 实例方法

-(void)dealloc
{
    self.model = nil;
    self.editPersonVC = nil;
    self.addressBookVC = nil;
    self.navigationController = nil;
    
    [super dealloc];
}

- (id)init
{
    if (self = [super init]) {
        CFAddressBookViewController * addressBookVC = [[CFAddressBookViewController alloc] init];
        self.addressBookVC = addressBookVC;
        [addressBookVC release];
        
        CFEditPersonViewController * editPersonVC = [[CFEditPersonViewController alloc] init];
        self.editPersonVC = editPersonVC;
        [editPersonVC release];
        
        UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController: addressBookVC];
        self.navigationController = navigationController;
        [navigationController release];
        
        CFAddressBookModel * addressBookModel = [[CFAddressBookModel alloc] init];
        self.model = addressBookModel;
        [addressBookModel release];
        
    }
    
    return self;
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


- (BOOL) removePersonWithTel: (NSString *) tel
{
    BOOL success = [self.model removePersonWithTel: tel];
    return success;
}

- (void)setModel:(CFAddressBookModel *)model
{
    [model addObserver: self forKeyPath: @"persons" options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld context: NULL];
    [model retain];
    
    [_model removeObserver: self forKeyPath:@"persons"];
    [_model release];
    
    _model = model;
}

- (NSDictionary *) dictionaryOfPersons
{
    return self.model.persons;
}
@end
