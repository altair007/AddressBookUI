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

@end
