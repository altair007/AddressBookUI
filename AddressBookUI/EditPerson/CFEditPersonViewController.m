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
#import "CFAddressBookViewController.h"
#import "CFAddressBookView.h"

@interface CFEditPersonViewController ()

@end

static CFEditPersonViewController * sharedObj = nil;
@implementation CFEditPersonViewController
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
        self = [self initWithNibName:nil bundle:nil];
        return self;
    }
}

-(void)dealloc
{
    self.person = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @synchronized(self){
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            // Custom initialization
        }
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
    if (NO == self.editing) { // 页面处于"不可编辑"状态
        [self setEditing: ! self.editing animated:YES];
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
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"提示" message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    alertView.tag = TAG_ALERTVIEW_SAVE;
    if (NO == result) {
        alertView.message = @"保存失败";
    }
    
    [alertView show];
    
    // 更新通讯录主视图
    if (YES == result) {
        [self setEditing: ! self.editing animated:YES];
    }
    
    // 更新导航栏
    [self updateTitle];
 }

- (void) didClickReverseBackButtonItemAction: (UIBarButtonItem *) aButtonItem
{
    // 是否是用户的误操作?
    if (YES == self.editing) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您正在编辑联系人信息,确定离开?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = TAG_ALERTVIEW_REVERSEBACK;
        [alertView show];
        return;
    }
    
    // 返回上一级
    [self.navigationController popViewControllerAnimated: YES];
}

-(void)setPerson:(CFPerson *)person
{
    // 设置实例变量
    [person retain];
    [_person release];
    _person = person;
    
    // 更新导航栏
    [self updateTitle];
    
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

- (void) updateTitle
{
    self.navigationItem.title = self.person.name;
    if (nil == self.navigationItem.title) {
        self.navigationItem.title = @"添加联系人";
    }
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

#pragma mark - <UIAlertViewDelegate>协议方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (TAG_ALERTVIEW_REVERSEBACK == alertView.tag) {
        if (INDEX_CONFIRM_BUTTON == buttonIndex) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if (TAG_ALERTVIEW_SAVE == alertView.tag) {
        if (NO == self.editing) {
            CFAddressBookViewController * addressBookVC = [CFAddressBookViewController sharedInstance];
            // ???:有没有必要把视图,也单例化?
            [(CFAddressBookView *)(addressBookVC.view) reloadData];
//            CFMainViewController * mainVC = (CFMainViewController *)(self.navigationController);
//            [(CFAddressBookView *)(mainVC.addressBookVC.view) reloadData];
        }
    }
}

@end
