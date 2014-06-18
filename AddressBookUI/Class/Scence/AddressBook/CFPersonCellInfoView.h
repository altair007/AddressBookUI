//
//  CFPersonCellInfoView.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-11.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFPerson;

// 属性的键
#define kNameLabel @"nameLabel"
#define kTelLabel @"telLabel"
#define kIntroLabel @"introLabel"

// 默认高度,不含简介部分.
#define DEFAULT_HEIGHT 80.0
#define DEFAULT_WIDTH 160.0

// 默认文本字体字体尺寸
#define DEFAULT_FONT_SIZE 15.0

/**
 *  联系人表格的信息视图部分.
 */
@interface CFPersonCellInfoView : UIView
@property (retain, nonatomic) CFPerson * person; //!< 联系人
@property (retain, nonatomic, readonly) UILabel * nameLabel; //!< 姓名.
@property (retain, nonatomic, readonly) UILabel * telLabel; //!< 联系方式.
@property (retain, nonatomic, readonly) UILabel * introLabel; //!< 简介.

/**
 *  根据联系人返回不同的单元格高度.
 *
 *  @param aPerson 联系人.
 *
 *  @return 单元格高度
 */
+ (CGFloat) heightWithPerson: (CFPerson *) aPerson;

/**
 *  获取单元格高度
 *
 *  @return 获取单元格高度
 */
- (CGFloat) height;

/**
 *  设置子视图.此处会将"简介"属性的边框高度设为0.0,以便于单元格高度值的计算.
 *
 */
- (void)setupSubviews;

/**
 *  更新视图内容.通常在设置person之后,会向对象发送此消息.
 */
- (void) updateContentOfView;

/**
 *  更新视图边框信息,通常在更新视图内容后,向对象发送此消息.
 */
- (void) updateFrameOfView;

@end
