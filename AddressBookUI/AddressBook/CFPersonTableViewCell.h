//
//  CFPersonTableViewCell.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-10.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFPerson;

// 属性的键
#define kAvatarIV @"avatarIV"
#define kNameLabel @"nameLabel"
#define kTelLabel @"telLabel"
#define kIntroLabel @"introLabel"

/**
 *  用于显示联系人的单元格
 */
@interface CFPersonTableViewCell : UITableViewCell
@property (retain, nonatomic) CFPerson * person; //!<  联系人.
@property (retain, nonatomic, readonly) UIImageView * avatarIV; //!< 联系人头像.
// FIXME:应该把contentView封装成一个类.
@property (retain, nonatomic, readonly) UIView * infoView; //!< 下面几个属性的父视图.
@property (retain, nonatomic, readonly) UILabel * nameLabel; //!< 姓名.
@property (retain, nonatomic, readonly) UILabel * telLabel; //!< 联系方式.
@property (retain, nonatomic, readonly) UILabel * introLabel; //!< 简介.

/**
 *  返回单元格高度.
 *
 *  @return 单元格高度.
 */
- (CGFloat) height;

/**
 *  设置子视图
 *
 *  @param rect 边框
 */
- (void)setupSubviews: (CGRect) rect;

@end
