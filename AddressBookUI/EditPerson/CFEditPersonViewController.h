//
//  CFEditPersonViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-9.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFPerson;

@interface CFEditPersonViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (retain, nonatomic) CFPerson * person;

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

@end
