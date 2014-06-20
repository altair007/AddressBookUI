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
 *  处理从输入框获取的联系人信息.
 *
 *  此方法在用户点击"保存"时,会被调用.此方法恒返回NO.子类应重写此方法以指定如何处理输入框中获取的联系人信息.
 *  如果返回值为YES,会使用此联系人设置控制器的person属性.
 *  子类重写方法中,你直接处理传入的联系人数据即可,不必再判断数据是否符合要求.在超类方法中已经存在相关逻辑.
 *
 *  @param person 联系人,根据输入框的内容创建的联系人对象.
 *
 *  @return YES,处理成功;NO,处理失败.
 */
- (BOOL) handleDataOfPerson: (CFPerson *) person;

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
