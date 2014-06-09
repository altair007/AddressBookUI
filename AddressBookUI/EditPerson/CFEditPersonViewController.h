//
//  CFEditPersonViewController.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-9.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFPerson;

// 点击"返回"和"保存"按钮弹出的视图的tag值
#define TAG_ALERTVIEW_REVERSEBACK 100
#define TAG_ALERTVIEW_SAVE 101

// 弹出视图中"确定"或"取消"按钮的索引值
#define INDEX_CONFIRM_BUTTON 0
#define INDEX_CANCEL_BUTTON 1

@interface CFEditPersonViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
@property (retain, nonatomic) CFPerson * person;

/**
 *  获取单例
 *
 *  @return 单例
 */
+ (instancetype) sharedInstance;

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
@end
