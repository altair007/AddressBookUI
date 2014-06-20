//
//  CFEditPersonView.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-9.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFPerson;
@class CFAvatarView;

@interface CFEditPersonView : UIView
@property (retain ,nonatomic) CFPerson * person; //!< 联系人
@property (assign, nonatomic) id<UITextFieldDelegate, UITextViewDelegate> delegate; //!< 代理
@property (retain, nonatomic, readonly) CFAvatarView * avatarView; //!< 相片视图
@property (retain, nonatomic, readonly) UITextField * nameTF; //!< 姓名编辑框
@property (retain, nonatomic, readonly) UITextField * sexTF; //!< 性别编辑框
@property (retain, nonatomic, readonly) UITextField * ageTF; //!< 年龄编辑框
@property (retain, nonatomic, readonly) UITextField * telTF; //!< 联系方式编辑框
@property (retain, nonatomic, readonly) UITextView * introTV; //!< 简介编辑

- (instancetype) initWithFrame: (CGRect)frame
                      delegate: (id) delegate;

/**
 *  设置子视图
 *
 *  @param rect 边框
 */
- (void)setupSubviews;

@end

