//
//  CFEditPersonViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-9.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//


#import <AssetsLibrary/AssetsLibrary.h>
#import "CFEditPersonViewController.h"
#import "CFEditPersonView.h"
#import "CFPerson.h"
#import "CFMainViewController.h"
#import "CFAddressBookModel.h"
#include "CFAddressBookViewController.h"
#include "CFAddressBookView.h"

@interface CFEditPersonViewController ()

@end

@implementation CFEditPersonViewController
-(void)dealloc
{
    self.person = nil;
    
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

- (void)loadView
{
    CFEditPersonView * editPersonView = [[CFEditPersonView alloc] initWithFrame: [UIScreen mainScreen].bounds delegate:self];
    
    self.view = editPersonView;
    [editPersonView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickReverseBackButtonItemAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didClickSaveButtonItemAction:)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && nil == self.view.window) {
        self.view = nil;
    }
}

-(void) didClickSaveButtonItemAction: (UIBarButtonItem *) aButtonItem
{
    // 该变页面编辑状态
    [self setEditing: ! self.editing animated:YES];
    
    if (YES == self.editing) { // 页面原处于"不可编辑"状态,则直接返回.
        return;
    }
    
    // 保存数据
    CFMainViewController * mainVC = (CFMainViewController *)(self.navigationController);
    
    // 获取信息
    CFEditPersonView * editPersonView = (CFEditPersonView *) self.view;
    NSString * name = editPersonView.nameTF.text;
    NSString * avatar = editPersonView.person.avatar;
    NSString * sex = editPersonView.sexTF.text;
    NSInteger age = [editPersonView.ageTF.text integerValue];
    NSString * tel = editPersonView.telTF.text;
    
    // 获取视图关联的联系人,并更新属性信息
    CFPerson * person = ((CFEditPersonView *)(self.view)).person;
    person.name = name;
    person.avatar = avatar;
    person.sex = sex;
    person.age = age;
    person.tel = tel;
    
    // 保存联系人信息
    BOOL result =  [mainVC.model  addPerson: person];
    
    // 提示信息
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    if (NO == result) {
        alertView.message = @"保存失败";
    }
    
    [alertView show];
    
    // 更新通讯录主视图
    // FIXME:点击保存时,有一个明显的延迟!到底应该在何处重载数据?设置状态里面?
    // ???:视图默认编辑状态是什么?
    if (YES == result) {
        [(CFAddressBookView *)(mainVC.addressBookVC.view) reloadData];
    }

 }

- (void) didClickReverseBackButtonItemAction: (UIBarButtonItem *) aButtonItem
{
    // 返回上一级
    [self.navigationController popViewControllerAnimated: YES];
}

-(void)setPerson:(CFPerson *)person
{
    // 设置实例变量
    [person retain];
    [_person release];
    _person = person;
    
    // 向视图传值
    ((CFEditPersonView *)(self.view)).person = _person;
}

- (void) handlAvatarViewTapGesture: (UITapGestureRecognizer *) tapGesture
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * imagePC = [[UIImagePickerController alloc] init];
        imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePC.delegate = self;
        [self presentViewController:imagePC animated:YES completion:NULL];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated: animated];
    
    CFEditPersonView * editPersonView = (CFEditPersonView *)self.view;
    
    if (YES == self.editing) {// 转换至编辑状态
        self.navigationItem.rightBarButtonItem.title = @"保存";
        editPersonView.avatarImageView.userInteractionEnabled = YES;
        editPersonView.nameTF.enabled = YES;
        editPersonView.sexTF.enabled = YES;
        editPersonView.ageTF.enabled = YES;
        editPersonView.telTF.enabled = YES;
        return;
    }
    
    // 转换至不可编辑状态
    self.navigationItem.rightBarButtonItem.title = @"编辑";
    editPersonView.avatarImageView.userInteractionEnabled = NO;
    editPersonView.nameTF.enabled = NO;
    editPersonView.sexTF.enabled = NO;
    editPersonView.ageTF.enabled = NO;
    editPersonView.telTF.enabled = NO;
    
}

#pragma mark - <UITextFieldDelegate>协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - <UIImagePickerControllerDelegate>协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    CFEditPersonView * editPersonView = ((CFEditPersonView *) self.view);
    
    editPersonView.avatarImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    editPersonView.person.avatar = ((NSURL *)[info objectForKey:UIImagePickerControllerReferenceURL]).description;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您取消了选取照片的操作!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
