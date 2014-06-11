//
//  CFPersonCellInfoView.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-11.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

// 属性的键
#define kNameLabel @"nameLabel"
#define kTelLabel @"telLabel"
#define kIntroLabel @"introLabel"

// 默认高度,不含简介部分.
#define DEFAULT_HEIGHT 80.0

/**
 *  联系人表格的信息视图部分.
 */
@interface CFPersonCellInfoView : UIView
@property (retain, nonatomic, readonly) UILabel * nameLabel; //!< 姓名.
@property (retain, nonatomic, readonly) UILabel * telLabel; //!< 联系方式.
@property (retain, nonatomic, readonly) UILabel * introLabel; //!< 简介.

/**
 *  设置子视图.此处会将"简介"属性的边框高度设为0.0,以便于单元格高度值的计算.
 *
 */
- (void)setupSubviews;

@end
