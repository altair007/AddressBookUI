//
//  CFEditPersonViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-9.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "CFAddressBookViewController.h"
#import "CFEditPersonViewController.h"
#import "CFAddressBookView.h"
#import "CFAddressBookModel.h"
#import "CFPerson.h"
//#import "RIButtonItem.h"
#import "UIAlertView+Blocks.h"

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
    // 获取视图关联的联系人
    CFPerson * person = self.view.person;
    person.name = self.view.nameTF.text;
    person.avatarName = self.view.person.avatarName;
    person.sex = self.view.sexTF.text;
    person.age = [self.view.ageTF.text integerValue];
    person.tel = self.view.telTF.text;
    person.intro = self.view.introTV.text;
    
    BOOL result =  [[CFMainController sharedInstance] addPerson: person];
    
    // 提示信息
    NSString * message = @"保存失败";
    
    if (YES == result) {
        message = @"保存成功";
        // 更改页面编辑状态.
        [self setEditing: ! self.editing animated:YES];
        
        // 更新导航栏
        [self updateTitle];
    }
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle: @"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
 }

- (void) didClickReverseBackButtonItemAction: (UIBarButtonItem *) aButtonItem
{
    // 是否是用户的误操作?
    if (YES == self.editing) {
        RIButtonItem * cancelItem = [RIButtonItem itemWithLabel:@"取消" action:NULL];
        RIButtonItem * confirmItem = [RIButtonItem itemWithLabel:@"确定" action:^{
            
            // 转至通讯录主页面.
            [[CFMainController sharedInstance] switchToAddressBookView];
        }];
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您正在编辑联系人信息,确定离开?" cancelButtonItem: cancelItem otherButtonItems: confirmItem, nil];
        [alertView show];
        [alertView release];

        return;
    }
    
    // 返回上一级
    [[CFMainController sharedInstance] switchToAddressBookView];
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
    self.view.person = _person;
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
    
    if (YES == self.editing) {// 转换至编辑状态
        self.navigationItem.rightBarButtonItem.title = @"保存";
        
        [self enableViewEdit];
        
        return;
    }
    
    // 转换至不可编辑状态
    self.navigationItem.rightBarButtonItem.title = @"编辑";
    [self disableViewEdit];
}

- (void) updateTitle
{
    self.navigationItem.title = self.person.name;
    if (nil == self.navigationItem.title) {
        self.navigationItem.title = @"添加联系人";
    }
}

- (void) enableViewEdit
{
    self.view.avatarIV.userInteractionEnabled = YES;
    self.view.nameTF.enabled = YES;
    self.view.sexTF.enabled = YES;
    self.view.ageTF.enabled = YES;
    self.view.telTF.enabled = YES;
    self.view.introTV.editable = YES;
}

- (void) disableViewEdit
{
    self.view.avatarIV.userInteractionEnabled = NO;
    self.view.nameTF.enabled = NO;
    self.view.sexTF.enabled = NO;
    self.view.ageTF.enabled = NO;
    self.view.telTF.enabled = NO;
    self.view.introTV.editable = NO;
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
    self.view.avatarIV.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.view.person.avatarName = ((NSURL *)[info objectForKey:UIImagePickerControllerReferenceURL]).description;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您取消了选取照片的操作!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
