//
//  CFAddPersonView.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-8.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFAddPersonView : UIView
@property (assign, nonatomic, readwrite) id<UITextFieldDelegate> delegate; //!< 代理
@property (retain, nonatomic, readonly) NSString * nameOfdefaultImg; //!< 默认显示的图片
@property (retain, nonatomic) NSString * avatar; //!< 联系人头像路径
// ???: 更名为avatarImageView比较好吧?
@property (retain, nonatomic, readonly) UIImageView * avatarView; //!< 相片视图
@property (retain, nonatomic, readonly) UITextField * nameTF; //!< 姓名编辑框
@property (retain, nonatomic, readonly) UITextField * sexTF; //!< 性别编辑框
@property (retain, nonatomic, readonly) UITextField * ageTF; //!< 年龄编辑框
@property (retain, nonatomic, readonly) UITextField * telTF; //!< 联系方式编辑框

- (instancetype) initWithFrame:(CGRect) frame
           andNameOfDefaultImg:(NSString *) aImgName;

// 恢复默认设置
- (void) reset;

@end
