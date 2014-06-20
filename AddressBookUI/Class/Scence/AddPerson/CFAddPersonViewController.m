//
//  CFAddPersonViewController.m
//  AddressBookUI
//
//  Created by   颜风 on 14-6-20.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "CFAddPersonViewController.h"
#import "CFAddressBookModel.h"
#import "NSString+IsAllNumbers.h"
#import "CFPerson.h"
#import "CFAvatarView.h"

@interface CFAddPersonViewController ()

@end

@implementation CFAddPersonViewController
- (void)loadView
{
    CFAddPersonView * addPersonView = [[CFAddPersonView alloc] initWithFrame:[[UIScreen mainScreen] bounds] delegate: self];
    self.view = addPersonView;
    [addPersonView release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setEditing: YES animated: YES];
}

// !!!:优化一下!
-(void) didClickSaveButtonItemAction: (UIBarButtonItem *) aButtonItem
{
    if (NO == self.editing) { // 页面处于"不可编辑"状态
        [self setEditing: ! self.editing animated:YES];
        return;
    }
    
    /* 获取用户输入 */
    NSString * avatarName = ((CFEditPersonView *)self.view).avatarView.avatarName;
    NSString * name = self.view.nameTF.text;
    NSString * sex = self.view.sexTF.text;
    NSString * age = self.view.ageTF.text;
    NSString * tel = self.view.telTF.text;
    NSString * intro = self.view.introTV.text;
    
    // 年龄或手机号是否为空?
    if ([name isEqualToString: @""] || [tel isEqualToString: @""]) {
        NSString * message = @"姓名或者手机号不能为空!";
        [self showAlertViewWithMessage: message];
        return;
    }
    
    // 手机号是否全部为数字?
    if (NO == [tel isAllNumbers]) {
        NSString * message = @"手机号应当全部是数字!";
        [self showAlertViewWithMessage: message];
        return;
    }
    
    // 性别如果存在,必须为男或者女.
    if (NO == [sex isEqualToString: @""]) {
        if (NO == [sex isEqualToString: @"男"] && NO == [sex isEqualToString: @"女"]) {
            NSString * message = @"性别应当为\"男\"或者\"女\"!";
            [self showAlertViewWithMessage: message];
            return;
        }
    }
    
    // 年龄如果存在,必须为数字.
    if (NO == [age isEqualToString: @""]) {
        if (NO == [age isAllNumbers]) {
            NSString * message = @"年龄应当全部是数字!";
            [self showAlertViewWithMessage: message];
            return;
        }
    }
    
    // 获取视图关联的联系人
    BOOL realSex = NO;
    if ([sex isEqualToString: @"女"]) {
        realSex = YES;
    }
    
    // !!!: 添加页面也可能是"编辑"!此处的逻辑是不周全的!判断逻辑,应该是,是否是同一对象.
    CFPerson * person = [CFPerson personWithName: name avatar:avatarName sex:realSex age:[age integerValue] tel:tel intro: intro]
    ;
    
    // 添加联系人.
    if (NO == [[CFAddressBookModel sharedInstance] addPerson: person]) {
        NSString * message = @"保存失败";
        [self showAlertViewWithMessage: message];
        return;
    }
    
    [self setEditing: ! self.editing animated:YES];
    [self updateTitle];
    
    NSString * message = @"保存成功";
    [self showAlertViewWithMessage: message];
}

@end
