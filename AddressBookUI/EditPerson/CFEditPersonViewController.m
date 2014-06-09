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
    CFEditPersonView * editPersonView = [[CFEditPersonView alloc] init];
    editPersonView.delegate = self;
    
    self.view = editPersonView;
    [editPersonView release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickReverseBackButtonItemAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(didClickSaveButtonItemAction:)];
    
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
    // 获取信息
    CFEditPersonView * editPersonView = (CFEditPersonView *) self.view;
    NSString * name = editPersonView.nameTF.text;
    NSString * avatar = editPersonView.person.avatar;
    NSString * sex = editPersonView.sexTF.text;
    NSInteger age = [editPersonView.ageTF.text integerValue];
    NSString * tel = editPersonView.telTF.text;
    
    // 创建联系人
    CFPerson * person = [[CFPerson alloc] initWithName:name avatar:avatar sex:sex age:age tel:tel];
    
    // 保存联系人信息
    BOOL result =  [((CFMainViewController *)(self.navigationController)).model  addPerson: person];
    [person release];
    
    // 提示信息
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"提示" message:@"添加成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    if (NO == result) {
        alertView.message = @"添加联系人失败";
    }
    
    [alertView show];
}

- (void) didClickReverseBackButtonItemAction: (UIBarButtonItem *) aButtonItem
{
    // 视图恢复默认设置
    CFEditPersonView * editPersonView = (CFEditPersonView *)self.view;
    
    // 恢复默认设置
    [editPersonView reset];
    
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

// ???:应该可以删了!
-(void)viewWillAppear:(BOOL)animated
{
    [self.view setNeedsDisplay];
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
    
    editPersonView.avatarView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    editPersonView.person.avatar = ((NSURL *)[info objectForKey:UIImagePickerControllerMediaURL]).description;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您取消了选取照片的操作!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
