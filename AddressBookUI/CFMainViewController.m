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
#import "UIAlertView+Blocks.h"

@interface CFMainViewController ()

@end

@implementation CFMainViewController
-(void)dealloc
{
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
    // 保存联系人信息
    BOOL result =  [self.model  addPerson: object];
    
    // 提示信息
    NSString * message = @"保存失败";
    
    if (YES == result) {
        message = @"保存成功";
        // 更改页面编辑状态.
        [self.editPersonVC setEditing: ! self.editPersonVC.editing animated:YES];
        
        // 更新导航栏
        [self.editPersonVC updateTitle];
        
        // 通讯录刷新数据
        [self.addressBookVC.view reloadData];
    }
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];

//
//    
//    __block NSInteger countOfOld = 0; // 原通讯录中的联系人个数
//    __block NSInteger countOfNew = 0;// 新通讯录中的联系人个数
//    NSDictionary * dictOld = [change objectForKey: @"old"];
//    [dictOld enumerateKeysAndObjectsUsingBlock:^(id key, NSArray * arr, BOOL *stop) {
//        countOfOld += arr.count;
//    }];
//    
//    NSDictionary * dictNew = [change objectForKey: @"new"];
//    [dictNew enumerateKeysAndObjectsUsingBlock:^(id key, NSArray * arr, BOOL *stop) {
//        countOfNew += arr.count;
//    }];
//    
//    if (countOfNew < countOfOld) {// 说明是在删除联系人,不需要通讯录视图重新加载数据
//        return;
//    }
//    
//    [self.addressBookVC.view reloadData];
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
    //  给person添加一个观察者.
    // ???: 如何观察所有属性?
    [aPerson addObserver:self forKeyPath:@"intro" options:NSKeyValueObservingOptionNew |
     NSKeyValueObservingOptionOld context:NULL];
    
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
