//
//  CFEditPersonViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-9.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFMainController.h"
#import "CFEditPersonView.h"
@class CFPerson;

// 点击"返回"和"保存"按钮弹出的视图的tag值
#define TAG_ALERTVIEW_REVERSEBACK 100
#define TAG_ALERTVIEW_SAVE 101

@interface CFEditPersonViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (retain, nonatomic) CFPerson * person;
@property (retain, nonatomic) CFEditPersonView * view;

/**
 *  保存联系人信息
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
