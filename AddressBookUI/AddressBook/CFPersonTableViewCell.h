//
//  CFPersonTableViewCell.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-10.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CFPerson;
@class CFPersonCellInfoView;

// ???: 定义成类变量,更合适些吧?不同页面间,已经开始混乱了!

// 默认头像图片高度和高度
#define HEIGHT_AVATAR   120.0
#define WIDTH_AVATAR    80.0

// 图像默认距离左边界和上边界的内间距.
#define PADDING_LEFT_AVATAR WIDTH_AVATAR / 3
#define PADDING_UP_AVATAR   PADDING_LEFT_AVATAR / 2

/**
 *  用于显示联系人的单元格
 */
@interface CFPersonTableViewCell : UITableViewCell
@property (retain, nonatomic) CFPerson * person; //!<  联系人.
@property (retain, nonatomic, readonly) UIImageView * avatarIV; //!< 联系人头像.
@property (retain, nonatomic, readonly) CFPersonCellInfoView * infoView; //!< 联系人信息

/**
 *  根据联系人返回不同的单元格高度
 *
 *  @param aPerson 联系人
 *
 *  @return 单元格高度
 */
+ (CGFloat) heightWithPerson: (CFPerson *) aPerson;

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

/**
 *  更新视图内容.通常在设置person之后,会向对象发送此消息.
 */
- (void) updateContentOfView;

/**
 *  更新视图边框信息,通常在更新视图内容后,向对象发送此消息.
 */
- (void) updateFrameOfView;

@end
