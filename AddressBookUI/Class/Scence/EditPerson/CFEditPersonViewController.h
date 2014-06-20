//
//  CFEditPersonViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-9.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFEditPersonView.h"
@class CFPerson;

/**
 *  编辑页面控制器.一个超类,用于让"添加联系人页面"和"联系人详情页面"继承.
 */
@interface CFEditPersonViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (retain, nonatomic) CFPerson * person;
@property (retain, nonatomic) CFEditPersonView * view;

/**
 *  保存联系人信息.
 *
 *  默认执行任何操作,你可以根据需要在子类中重写这个方法.
 *
 *  @param aButtonItem 一个按钮项
 */
-(void) didClickSaveButtonItemAction: (UIBarButtonItem *) aButtonItem;

/**
 *  返回通讯录主页面
 *
 *  @param aButtonItem 一个按钮项
 */
- (void) didClickReverseBackButtonItemAction: (UIBarButtonItem *) aButtonItem;

/**
 *  响应头像视图的触摸手势
 *
 *  @param tapGesture 手势
 */
- (void) handlAvatarViewTapGesture: (UITapGestureRecognizer *) tapGesture;

/**
 *  更新导航栏标题.
 */
- (void) updateTitle;

/**
 *  使视图处于可编辑状态
 */
- (void) enableViewEdit;

/**
 *  使视图处于不可编辑状态
 */
- (void) disableViewEdit;

/**
 *  显示一个含有指定信息的弹出框.
 *
 *  @param aMessage 要显示的信息.
 */
- (void) showAlertViewWithMessage: (NSString *) aMessage;

@end
