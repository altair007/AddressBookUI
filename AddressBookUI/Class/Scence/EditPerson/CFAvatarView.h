//
//  CFAvatarView.h
//  AddressBookUI
//
//  Created by   颜风 on 14-6-14.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  联系人头像视图.
 */
@interface CFAvatarView : UIImageView
@property (copy, nonatomic) NSString * avatarName; //!< 图片名称.
@property (copy, nonatomic, readonly) NSString * defaultImg; //!< 默认图片.
@end
