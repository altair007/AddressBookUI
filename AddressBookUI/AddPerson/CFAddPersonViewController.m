//
//  CFAddPersonViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddPersonViewController.h"
#import "CFAddPersonView.h"
#import "CFPerson.h"
#import "CFMainViewController.h"
#import "CFAddressBookModel.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface CFAddPersonViewController ()

@end

@implementation CFAddPersonViewController

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
    CFAddPersonView * addPersonView = [[CFAddPersonView alloc] init];
    addPersonView.delegate = self;
    
    self.view = addPersonView;
    [addPersonView release];
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
    CFAddPersonView * addPersonView = (CFAddPersonView *) self.view;
    NSString * name = addPersonView.nameTF.text;
    // FIXME:暂时无法获取这个值.
    NSString * avatar = addPersonView.avatar;
    NSString * sex = addPersonView.sexTF.text;
    NSInteger age = [addPersonView.ageTF.text integerValue];
    NSString * tel = addPersonView.telTF.text;
    
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
    CFAddPersonView * addPersonView = (CFAddPersonView *)self.view;
    
    // 恢复默认设置
    [addPersonView reset];
    
    // 返回上一级
    [self.navigationController popViewControllerAnimated: YES];
}
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
    // ???:无法直接获取图片地址?
    CFAddPersonView * addPersonView = ((CFAddPersonView *) self.view);
    
    addPersonView.avatarView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    addPersonView.avatar = ((NSURL *)[info objectForKey:UIImagePickerControllerMediaURL]).description;
    
    // !!!:以下算法写到获取图片的算法中:分两种情况,一个是本地,一个是系统内置!
    NSURL * url = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSString * str = url.description;
    ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
    [lib assetForURL:[NSURL URLWithString:str] resultBlock:^(ALAsset *asset)
    {
        //在这里使用asset来获取图片
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        CGImageRef imgRef = [assetRep fullResolutionImage];
        UIImage *img = [UIImage imageWithCGImage:imgRef
                                           scale:assetRep.scale
                                     orientation:(UIImageOrientation)assetRep.orientation];
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }
        failureBlock:^(NSError *error)
    {
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }
     ];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您取消了选取照片的操作!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
